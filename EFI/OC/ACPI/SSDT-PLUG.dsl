/*
 * XCPM power management compatibility table.
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "CpuPlug", 0x00003000)
{
    External (_SB_.PR00, ProcessorObj)

    Method (PMPM, 4, NotSerialized) {
       If (LEqual (Arg2, Zero)) {
           Return (Buffer (One) { 0x03 })
       }

       Return (Package (0x02)
       {
           "plugin-type", 
           One
       })
    }

    If (CondRefOf (\_SB.PR00)) {
        If ((ObjectType (\_SB.PR00) == 0x0C)) {
            Scope (\_SB.PR00) {
                Method (_DSM, 4, NotSerialized)  
                {
                    Return (PMPM (Arg0, Arg1, Arg2, Arg3))
                }
            }
        }
    }
}
