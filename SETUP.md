# Backend API Creation Guidelines

**Tech Stack:**

* **Framework:** [NestJS](https://nestjs.com/)
* **Database:** PostgreSQL ([NeonDB](https://neon.tech/))
* **Architecture:** Monorepo Microservices, MVC Pattern


## 📂 Folder Structure in Monorepo

Standard folder structure for creating a new API in our setup:

```
apps/
  <service-name>/
    src/
      entity/                     # Database entities
      module/
        <module-name>/
          <module-name>.controller.ts
          <module-name>.service.ts
          <module-name>.module.ts
    test/                          # Unit tests for service & controller
```

---

## 📜 Generalized HTTP Status Codes

Fixed status codes for consistency across all microservices:

| Method | Action                | Status Code |
| ------ | --------------------- | ----------- |
| GET    | Success (fetch)       | 200         |
| POST   | Resource created      | 201         |
| PUT    | Resource updated      | 200         |
| DELETE | Resource deleted      | 200         |
| ANY    | Validation error      | 400         |
| ANY    | Unauthorized          | 401         |
| ANY    | Forbidden             | 403         |
| ANY    | Not found             | 404         |
| ANY    | Internal server error | 500         |

---

## 1️⃣ Create the Service Function

**Rules:**

* All business logic is in the **service**.
* Wrap logic in `try-catch`.
* Return standardized success/error format.
* Always throw `ResponseException` when there’s an error.

**Service Template:**

```typescript
// apps/<service-name>/src/module/<module-name>/<module-name>.service.ts
import { Injectable } from "@nestjs/common";
import { ResponseException } from "@shared/exceptions/response.exception";

@Injectable()
export class ModuleNameService {
    async functionName(id: number) {
        try {
            const result = await this.repository.findOne({ where: { id } });

            if (!result) {
                throw new ResponseException(404, "Resource not found");
            }

            return {
                status: true,
                message: "Resource fetched successfully",
                resource_name: result
            };
        } catch (error) {
            return {
                status: false,
                message: error?.message || "Internal server error",
                status_code: error?.status_code || 500
            };
        }
    }
}
```

---

## 2️⃣ Create the Controller

**Rules:**

* Controller should only handle request/response.
* Validate params/body.
* If service returns `status: false`, rethrow error.

**Controller Template:**

```typescript
// apps/<service-name>/src/module/<module-name>/<module-name>.controller.ts
import { Controller, Get, Param, Res } from "@nestjs/common";
import { Response } from "express";
import { ResponseException } from "@shared/exceptions/response.exception";

@Controller("module-name")
export class ModuleNameController {
    constructor(private readonly moduleService: ModuleNameService) {}

    @Get("/:id")
    async functionName(@Param("id") id: number, @Res() res: Response) {
        try {
            if (!id) {
                throw new ResponseException(400, "ID parameter is missing");
            }

            const result = await this.moduleService.functionName(id);

            if (!result.status) {
                throw new ResponseException(result.status_code!, result.message);
            }

            return res.status(201).json(result); // All success responses use 201
        } catch (error) {
            const status_code = error?.status_code || 500;
            const message = error?.message || "Internal server error";
            return res.status(status_code).json({
                status: false,
                message
            });
        }
    }
}
```

---

## 3️⃣ Standard Response Format

**✅ Success:**

```json
{
    "status": true,
    "message": "Resource fetched successfully",
    "resource_name": { }
}
```

**❌ Error:**

```json
{
    "status": false,
    "message": "Resource not found",
    "status_code": 404
}
```

---

## 4️⃣ API Development Workflow

1. Create **service function** → `apps/<service-name>/src/module/<module-name>/<module-name>.service.ts`
2. Add `try-catch` in service.
3. Create **controller** → `apps/<service-name>/src/module/<module-name>/<module-name>.controller.ts`
4. Use **generalized status codes** from this document.
5. Test locally before creating a PR.
6. Create PR following the push workflow.

---
