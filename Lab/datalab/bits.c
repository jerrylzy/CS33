/*
 * CS:APP Data Lab
 *
 *
 * bits.c - Source file with your solutions to the Lab.
 *          This is the file you will hand in to your instructor.
 *
 * WARNING: Do not include the <stdio.h> header; it confuses the dlc
 * compiler. You can still use printf for debugging without including
 * <stdio.h>, although you might get a compiler warning. In general,
 * it's not good practice to ignore compiler warnings, but in this
 * case it's OK.
 */

#if 0
/*
 * Instructions to Students:
 *
 * STEP 1: Read the following instructions carefully.
 */

You will provide your solution to the Data Lab by
editing the collection of functions in this source file.

INTEGER CODING RULES:

Replace the "return" statement in each function with one
or more lines of C code that implements the function. Your code
must conform to the following style:

int Funct(arg1, arg2, ...) {
    /* brief description of how your implementation works */
    int var1 = Expr1;
    ...
    int varM = ExprM;
    
    varJ = ExprJ;
    ...
    varN = ExprN;
    return ExprR;
}

Each "Expr" is an expression using ONLY the following:
1. Integer constants 0 through 255 (0xFF), inclusive. You are
not allowed to use big constants such as 0xffffffff.
2. Function arguments and local variables (no global variables).
3. Unary integer operations ! ~
4. Binary integer operations & ^ | + << >>

Some of the problems restrict the set of allowed operators even further.
Each "Expr" may consist of multiple operators. You are not restricted to
one operator per line.

You are expressly forbidden to:
1. Use any control constructs such as if, do, while, for, switch, etc.
2. Define or use any macros.
3. Define any additional functions in this file.
4. Call any functions.
5. Use any other operations, such as &&, ||, -, or ?:
6. Use any form of casting.
7. Use any data type other than int.  This implies that you
cannot use arrays, structs, or unions.


You may assume that your machine:
1. Uses 2s complement, 32-bit representations of integers.
2. Performs right shifts arithmetically.
3. Has unpredictable behavior when shifting an integer by more
than the word size.

EXAMPLES OF ACCEPTABLE CODING STYLE:
/*
 * pow2plus1 - returns 2^x + 1, where 0 <= x <= 31
 */
int pow2plus1(int x) {
    /* exploit ability of shifts to compute powers of 2 */
    return (1 << x) + 1;
}

/*
 * pow2plus4 - returns 2^x + 4, where 0 <= x <= 31
 */
int pow2plus4(int x) {
    /* exploit ability of shifts to compute powers of 2 */
    int result = (1 << x);
    result += 4;
    return result;
}

FLOATING POINT CODING RULES

For the problems that require you to implent floating-point operations,
the coding rules are less strict.  You are allowed to use looping and
conditional control.  You are allowed to use both ints and unsigneds.
You can use arbitrary integer and unsigned constants.

You are expressly forbidden to:
1. Define or use any macros.
2. Define any additional functions in this file.
3. Call any functions.
4. Use any form of casting.
5. Use any data type other than int or unsigned.  This means that you
cannot use arrays, structs, or unions.
6. Use any floating point data types, operations, or constants.


NOTES:
1. Use the dlc (data lab checker) compiler (described in the handout) to
check the legality of your solutions.
2. Each function has a maximum number of operators (! ~ & ^ | + << >>)
that you are allowed to use for your implementation of the function.
The max operator count is checked by dlc. Note that '=' is not
counted; you may use as many of these as you want without penalty.
3. Use the btest test harness to check your functions for correctness.
4. Use the BDD checker to formally verify your functions
5. The maximum number of ops for each function is given in the
header comment for each function. If there are any inconsistencies
between the maximum ops in the writeup and in this file, consider
this file the authoritative source.

/*
 * STEP 2: Modify the following functions according the coding rules.
 *
 *   IMPORTANT. TO AVOID GRADING SURPRISES:
 *   1. Use the dlc compiler to check that your solutions conform
 *      to the coding rules.
 *   2. Use the BDD checker to formally verify that your solutions produce
 *      the correct answers.
 */


#endif
/* howManyBits - return the minimum number of bits required to represent x in
 *             two's complement
 *  Examples: howManyBits(12) = 5
 *            howManyBits(298) = 10
 *            howManyBits(-5) = 4
 *            howManyBits(0)  = 1
 *            howManyBits(-1) = 1
 *            howManyBits(0x80000000) = 32
 *  Legal ops: ! ~ & ^ | + << >>
 *  Max ops: 90
 *  Rating: 4
 */
int howManyBits(int x) {

    /*
     * We first bit invert all negative numbers and
     * use binary search to find out the log2(n).
     * Then we add 1 to the final result since we need
     * the MSB to represent the sign.
     * Note: finding the following things are equal:
     * 1. find the most significant bit of 1 for positive numbers
     * 2. find the most significant bit of 0 for negative numbers
     */
    
    /* I hate this, but I have to avoid parse error */
    int sign, bit0, bit1, bit2, bit4, bit8, bit16;

    sign = x >> 31;
    
    /* Bit invert x as needed */
    x = (sign & ~x) | (~sign & x);
    
    /* Binary Search on bit level */
    bit16 = !!(x >> 16) << 4;
    x = x >> bit16;
    
    bit8 = !!(x >> 8) << 3;
    x = x >> bit8;
    
    bit4 = !!(x >> 4) << 2;
    x = x >> bit4;
    
    bit2 = !!(x >> 2) << 1;
    x = x >> bit2;
    
    bit1 = !!(x >> 1);
    x = x >> bit1;
    
    bit0 = x;

    return bit16 + bit8 + bit4 + bit2 + bit1 + bit0 + 1;
}
/*
 * sm2tc - Convert from sign-magnitude to two's complement
 *   where the MSB is the sign bit
 *   Example: sm2tc(0x80000005) = -5.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 15
 *   Rating: 4
 */
int sm2tc(int x) {
    /* We determine negativity of the integer x,
     * if the integer is negative, we subtract off the MSB
     * and negate it using Two's complement
     */
    int sign = x >> 31;
    return (sign & (~(x + ~(~0 << 31) + 1) + 1)) | (~sign & x);
}
/*
 * isNonNegative - return 1 if x >= 0, return 0 otherwise
 *   Example: isNonNegative(-1) = 0.  isNonNegative(0) = 1.
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 6
 *   Rating: 3
 */
int isNonNegative(int x) {
    /* We move the MSB to the LSB and see if it is zero or one */
    return !(x >> 31);
}

/*
 * rotateRight - Rotate x to the right by n
 *   Can assume that 0 <= n <= 31
 *   Examples: rotateRight(0x87654321,4) = 0x76543218
 *   Legal ops: ~ & ^ | + << >>
 *   Max ops: 25
 *   Rating: 3
 */
int rotateRight(int x, int n) {
    /* 
     * we basically move the part moved right to the LSB to the left
     * and connect it with the shifted integer x.
     */
    int negOne = ~0; /* Declare a variable for later usage */
    int nonZero = !n + negOne;
    int pos = nonZero & (33 + ~n);  /* if it is zero then do nothing */
    /* 
     * we basically convert the front part of x to
     * prevent overflow with a mask
     */
    int maskToPreventOverflow = (!(nonZero & x >> (n + negOne) & 0x01) + negOne) << n;
    int front = (x | maskToPreventOverflow) << pos;
    int back = x >> n;
    int mask = (~0) << pos;
    return (front & mask) | (back & ~mask);
}
/*
 * divpwr2 - Compute x/(2^n), for 0 <= n <= 30
 *  Round toward zero
 *   Examples: divpwr2(15,1) = 7, divpwr2(-33,4) = -2
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 15
 *   Rating: 2
 */
int divpwr2(int x, int n) {
    /* 
     * The condition stands for x >= 0; if the condition fails
     * we add a bias of 2^n - 1 to the number to round toward zero
     */
    int cond = ~(x >> 31);
    return ((cond & x) | (~cond & (x + (1 << n) + ~0))) >> n;
}
/*
 * allOddBits - return 1 if all odd-numbered bits in word set to 1
 *   Examples allOddBits(0xFFFFFFFD) = 0, allOddBits(0xAAAAAAAA) = 1
 *   Legal ops: ! ~ & ^ | + << >>
 *   Max ops: 12
 *   Rating: 2
 */
int allOddBits(int x) {
    /* we create a mask for even bits to prevent overflow */
    int m = 0x55;
    int mask = m | (m << 8);
    /* bit invert the mask to odd bits mask */
    mask = ~(mask + (mask << 16));
    return !((x & mask) + ~mask + 1);
}
/*
 * bitXor - x^y using only ~ and &
 *   Example: bitXor(4, 5) = 1
 *   Legal ops: ~ &
 *   Max ops: 14
 *   Rating: 1
 */
int bitXor(int x, int y) {
    /* 
     * bit wise xor is the bit invert of bitwise '&' 
     * and the bitwise 'nor'.
     */
    return ~(x & y) & ~(~x & ~y);
}
/*
 * isTmin - returns 1 if x is the minimum, two's complement number,
 *     and 0 otherwise
 *   Legal ops: ! ~ & ^ | +
 *   Max ops: 10
 *   Rating: 1
 */
int isTmin(int x) {
    /* 
     * For this particular problem we use wrapv camp
     * We check whether x and its negation are equal
     * and make sure that x is not equal to zero
     */
    return !((x^(~x + 1)) + !x);
}
