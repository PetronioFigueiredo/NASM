#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <fcntl.h>

#define MAX_CODE_LENGTH 256

void print_menu() {
    system("clear");
    printf("\n\x1b[1mAssembly x86 Learning Tool\x1b[0m\n");
    printf("1. Basic Instructions Tutorial\n");
    printf("2. Practice Exercises\n");
    printf("3. Write and Execute Assembly Code\n");
    printf("4. Disassemble a Binary\n");
    printf("5. Exit\n");
    printf("Select an option: ");
}

void basic_tutorial() {
    system("clear");
    printf("\n\x1b[1;34mBasic x86 Assembly Tutorial\x1b[0m\n");
    printf("===========================\n");
    printf("\n\x1b[1mRegisters:\x1b[0m\n");
    printf("EAX, EBX, ECX, EDX - General purpose registers\n");
    printf("ESI, EDI - Source/Destination index registers\n");
    printf("ESP - Stack pointer\n");
    printf("EBP - Base pointer\n");
    printf("EIP - Instruction pointer\n");
    
    printf("\n\x1b[1mBasic Instructions:\x1b[0m\n");
    printf("mov eax, ebx  - Copy ebx to eax\n");
    printf("add eax, 5    - Add 5 to eax\n");
    printf("sub ebx, ecx  - Subtract ecx from ebx\n");
    printf("cmp eax, ebx  - Compare eax and ebx\n");
    printf("jmp label     - Jump to label\n");
    printf("call function - Call a function\n");
    printf("ret           - Return from function\n");
    
    printf("\n\x1b[1mMemory Access:\x1b[0m\n");
    printf("[eax]         - Access memory at eax address\n");
    printf("[ebx+4]       - Access memory at ebx+4 address\n");
    
    printf("\n\x1b[1mSystem Calls:\x1b[0m\n");
    printf("int 0x80      - Make system call (Linux)\n");
    printf("eax contains syscall number\n");
    printf("ebx, ecx, edx contain arguments\n");
    
    printf("\nPress Enter to continue...");
    getchar(); getchar();
}

void practice_exercises() {
    system("clear");
    int answer;
    printf("\n\x1b[1;34mPractice Exercises\x1b[0m\n");
    printf("===================\n");
    
    printf("\n\x1b[1mQuestion 1:\x1b[0m What does 'mov eax, ebx' do?\n");
    printf("1. Moves ebx to eax\n");
    printf("2. Moves eax to ebx\n");
    printf("3. Compares eax and ebx\n");
    printf("Your answer: ");
    scanf("%d", &answer);
    if (answer == 1) {
        printf("\x1b[32mCorrect!\x1b[0m\n");
    } else {
        printf("\x1b[31mIncorrect. The correct answer is 1.\x1b[0m\n");
    }
    
    system("clear");
    printf("\n\x1b[1mQuestion 2:\x1b[0m What does 'add eax, 5' do?\n");
    printf("1. Compares eax with 5\n");
    printf("2. Adds 5 to eax\n");
    printf("3. Moves 5 to eax\n");
    printf("Your answer: ");
    scanf("%d", &answer);
    if (answer == 2) {
        printf("\x1b[32mCorrect!\x1b[0m\n");
    } else {
        printf("\x1b[31mIncorrect. The correct answer is 2.\x1b[0m\n");
    }
    
    printf("\nPress Enter to continue...");
    getchar(); getchar();
}

void write_and_execute() {
    char code[MAX_CODE_LENGTH];
    char filename[] = "temp_asm.s";
    char command[256];
    FILE *fp;
    
    printf("\n\x1b[1;34mWrite and Execute Assembly Code\x1b[0m\n");
    printf("===============================\n");
    printf("Enter your assembly code (max %d chars). End with 'end:' on a new line:\n", MAX_CODE_LENGTH);
    
    // Clear input buffer
    int c;
    while ((c = getchar()) != '\n' && c != EOF);
    
    // Read multi-line input
    fp = fopen(filename, "w");
    if (!fp) {
        perror("Failed to create temporary file");
        return;
    }
    
    // Write standard headers
    fprintf(fp, ".globl _start\n");
    fprintf(fp, ".section .text\n");
    fprintf(fp, "_start:\n");
    
    // Read user input until "end:" is encountered
    printf("(Start typing your assembly code, 'end:' to finish)\n");
    while (fgets(code, sizeof(code), stdin)) {
        if (strcmp(code, "end:\n") == 0) break;
        fputs(code, fp);
    }
    
    // Add exit syscall if not present
    fprintf(fp, "    mov eax, 1       # sys_exit\n");
    fprintf(fp, "    mov ebx, 0       # exit code\n");
    fprintf(fp, "    int 0x80\n");
    
    fclose(fp);
    
    // Assemble and link
    printf("\nAssembling and linking...\n");
    snprintf(command, sizeof(command), "as --32 -o temp_asm.o %s && ld -m elf_i386 -o temp_asm temp_asm.o", filename);
    if (system(command) != 0) {
        printf("Error in assembly. Check your code.\n");
        return;
    }
    
    // Execute
    printf("Executing...\n");
    printf("------------ Output ------------\n");
    system("./temp_asm");
    printf("-------------------------------\n");
    printf("Exit status: %d\n", WEXITSTATUS(system("./temp_asm")));
    
    // Clean up
    unlink("temp_asm.o");
    unlink("temp_asm");
    unlink(filename);
    
    printf("\nPress Enter to continue...");
    getchar();
}

void disassemble_binary() {
    char binary[256];
    char command[512];
    
    printf("\n\x1b[1;34mDisassemble a Binary\x1b[0m\n");
    printf("======================\n");
    printf("Enter path to binary file: ");
    scanf("%255s", binary);
    
    // Check if file exists
    if(access(binary, F_OK))
	{
        printf("File does not exist or cannot be accessed.\n");
        return;
    	};
    
    // Use objdump to disassemble
    snprintf(command, sizeof(command), "objdump -d -M intel \"%s\" | less", binary);
    printf("\nDisassembly output:\n");
    system(command);
    
    printf("\nPress Enter to continue...");
    getchar(); getchar();
}

int main() {
    int choice;
    system("clear");
    
    printf("\x1b[1mWelcome to the x86 Assembly Learning Tool!\x1b[0m\n");
    printf("This program will help you learn x86 assembly on Linux.\n");
    
    while (1) {
        print_menu();
        scanf("%d", &choice);
        
        switch (choice) {
            case 1:
                basic_tutorial();
                break;
            case 2:
                practice_exercises();
                break;
            case 3:
                write_and_execute();
                break;
            case 4:
                disassemble_binary();
                break;
            case 5:
                printf("Exiting...\n");
                return 0;
            default:
                printf("Invalid choice. Please try again.\n");
        }
    }
    
    return 0;
}
