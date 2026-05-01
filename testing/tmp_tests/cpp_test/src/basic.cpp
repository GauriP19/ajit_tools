extern "C" int cpp_test_value()
{
    int total = 0;

    for (int i = 1; i <= 5; ++i) {
        total += i * i;
    }

    return total == 55 ? 0 : 1;
}

extern "C" int main()
{
    return cpp_test_value();
}
