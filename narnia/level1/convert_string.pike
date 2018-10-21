#!/usr/bin/pike

class Shell
{
    inherit ADT.Struct;
    Item s1 = Gnol();
    Item s2 = Gnol();
}

int main()
{
    Shell s = Shell("//bin/sh");
    werror("0x%x\n0x%x\n", s->s2, s->s1);
}
