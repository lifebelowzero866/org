interface Section {
    section_id: number
    section: string
    boys_count: number
    girls_count: number
}

interface StudentSection {
    student_id: number
    section_id: number
}

const sections: Section[] = [
    {
        section_id: 1,
        section: "A",
        boys_count: 0,
        girls_count: 0
    },
    {
        section_id: 2,
        section: "B",
        boys_count: 0,
        girls_count: 0
    },
    {
        section_id: 3,
        section: "C",
        boys_count: 0,
        girls_count: 0
    }
]


const student_section: StudentSection[] = []

const assignStudentToSection = (student_id: number, gender: string) => {
    if (gender == "Male") {
        let secc: Section = sections[0]

        for (let [index, sec] of sections.entries()) {
            if (sec.boys_count === 0) {
                secc = sec;
                sections[index].boys_count++
                break
            }
            if (secc.boys_count > sec.boys_count) {
                secc = sec
                sections[index].boys_count++
            }
        }
        
        const ss: StudentSection = {
            student_id: student_id,
            section_id: secc.section_id
        }

        student_section.push(ss)

    } else {
        let secc: Section = sections[0]
        for (let [index, sec] of sections.entries()) {
            if (sec.girls_count === 0) {
                secc = sec;
                sections[index].girls_count++
                break
            }
            if (secc.girls_count > sec.girls_count) {
                secc = sec
                sections[index].girls_count++
            }
        }

        const ss: StudentSection = {
            student_id: student_id,
            section_id: secc.section_id
        }

        student_section.push(ss)
    }
}

assignStudentToSection(1, "Male")
assignStudentToSection(2, "Male")
assignStudentToSection(3, "Female")
assignStudentToSection(4, "Female")
console.log(sections)
console.log(student_section)