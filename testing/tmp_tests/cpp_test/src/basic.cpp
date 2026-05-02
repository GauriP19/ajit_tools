extern "C" {
void ajit_serial_init();
int ee_printf(const char *fmt, ...);
}

class Accumulator {
public:
    void add_square(int x) {
        total += x * x;
    }

    int value() const {
        return total;
    }

private:
    int total = 0;
};

int main()
{
    Accumulator acc;
    volatile int limit = 5;

    for (int i = 1; i <= limit; ++i) {
        acc.add_square(i);
    }

    ajit_serial_init();

    int total = acc.value();
    if (total == 55) {
        ee_printf("cpp_test: PASS, sum of squares = %d\n", total);
    } else {
        ee_printf("cpp_test: FAIL, sum of squares = %d, expected 55\n", total);
    }

    return 0;
}
