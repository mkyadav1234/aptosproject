module MyModule::EducationalRewards {

    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    /// Struct representing a student with their earned tokens.
    struct Student has store, key {
        total_tokens: u64,  // Total tokens earned by the student
    }

    /// Function to register a new student.
    public fun register_student(teacher: &signer, student_address: address) {
        let student = Student {
            total_tokens: 0,  // Start with 0 tokens
        };
        move_to(teacher, student);
    }

    /// Function to reward tokens to a student for academic achievement.
    public fun reward_tokens(teacher: &signer, student_address: address, tokens: u64) acquires Student {
        let student = borrow_global_mut<Student>(student_address);

        // Transfer tokens from the teacher to the student
        let reward = coin::withdraw<AptosCoin>(teacher, tokens);
        coin::deposit<AptosCoin>(student_address, reward);

        // Update the student's total tokens
        student.total_tokens = student.total_tokens + tokens;
    }
}
