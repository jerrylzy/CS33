/*
 *
 * A. %rdi = x, %rsi = n, %rax = result, %rdx = mask
 * B. result = 0; mask = 1;
 * C. Test Condition for mask: mask != 0;
 * D. mask is left shifted by the amount of (the bottom 8 bits of) n
 * E. result = result | (mask & x);
 * F. Shown Below
 *
 */

long loop(long x, long n)
{
    long result = 0;
    long mask;
    for (mask = 1; mask != 0; mask = mask << n)
    {
     	result |= (mask & x);
    }
    return result;
}
