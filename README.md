# Cluster

Welcome to the Cluster repository. This project is focused on building an Educational ERP System. This README file provides an overview of the project, instructions for getting started, and coding conventions that all contributors should follow.

## Table of Contents

- [Project Overview](#project-overview)
- [Getting Started](#getting-started)
- [Contributing](#contributing)
- [Coding Conventions](#coding-conventions)
- [Branch Naming](#branch-naming)
- [License](#license)

## Project Overview

The Cluster ERP System is a transformative solution that empowers educational institutions to achieve their academic and administrative goals effectively. By embracing this system, institutions can foster collaboration, improve outcomes, and create a robust foundation for future growth.

## Getting Started

To get a local copy of the project up and running, follow these simple steps.

### Prerequisites

- Node.js
- npm (Node Package Manager)
- Nest
- MySQL
- Git

### Installation

1. Clone the repository:
   ```sh
   git clone git@github.com:The-Tech-Forge/Cluster-Backend.git
   ```

2. Navigate to the project directory:
   ```sh
   cd Cluster-Backend
   ```

3. Install dependencies:
   ```sh
   npm install
   ```

4. Start the development server:
   ```sh
   npm dev
   ```

5. Open your browser and visit `http://<IP Address>:8080` to see the application in action.

## Contributing

We welcome contributions from the community. To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b DEV_NAME_FEATURE`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin DEV_NAME_FEATURE`).
6. Open a Pull Request.

Please ensure your code adheres to the coding conventions specified below.

## Coding Conventions

To maintain code quality and readability, please adhere to the following naming conventions:

- **Classes**: Use Pascal Case
  - Example: `UserProfile`, `PaymentProcessor`
- **Functions**: Use Camel Case
  - Example: `getUserProfile()`, `processPayment()`
- **Variables**: Use Snake Case
  - Example: `user_name`, `payment_amount`

Additionally, ensure that filenames and class names are the same.

### Example


### Filename: UserProfile.ts

```
class UserProfile{
    getUserDetails=async(req,res)=>{
        const user_name  = "John Doe";
    }
}
``` 


## Branch Naming

For alternate branches, use the following format:
```
- `DEV_NAME_FEATURE`
- Example: `JOHN_DOE_PAYMENT_INTEGRATION`
```
