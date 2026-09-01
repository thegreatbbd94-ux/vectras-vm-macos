package com.vectras.vm;

import com.google.gson.Gson;
import com.vectras.vm.main.vms.DataMainRoms;
import com.vectras.vm.manager.ParamManager;
import com.vectras.vm.manager.VmListManager;

import org.junit.Test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class OpenCoreCatalinaTest {

    @Test
    public void testDataMainRomsOpenCoreField() {
        DataMainRoms rom = new DataMainRoms();
        rom.itemName = "macOS Catalina";
        rom.itemArch = "X86_64";
        rom.isOpenCore = true;
        rom.isUseUefi = true;
        rom.machine = 2; // q35
        rom.cpu = 19; // Penryn
        rom.memory = 2048;
        rom.itemExtra = "-device isa-applesmc,osk=\"ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc\" -smbios type=2";

        Gson gson = new Gson();
        String json = gson.toJson(rom);
        assertTrue(json.contains("\"isOpenCore\":true"));

        DataMainRoms deserialized = gson.fromJson(json, DataMainRoms.class);
        assertTrue(deserialized.isOpenCore);
        assertEquals("macOS Catalina", deserialized.itemName);
        assertTrue(deserialized.itemExtra.contains("isa-applesmc"));
        assertTrue(deserialized.itemExtra.contains("ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"));
    }

    @Test
    public void testVmListManagerIsSameVmConfigOpenCore() {
        DataMainRoms rom1 = new DataMainRoms();
        rom1.vmID = "123";
        rom1.itemName = "macOS Catalina";
        rom1.isOpenCore = true;
        rom1.isUseUefi = true;

        DataMainRoms rom2 = new DataMainRoms();
        rom2.vmID = "123";
        rom2.itemName = "macOS Catalina";
        rom2.isOpenCore = false;
        rom2.isUseUefi = true;

        assertFalse(VmListManager.isSameVmConfig(rom1, rom2));

        rom2.isOpenCore = true;
        assertTrue(VmListManager.isSameVmConfig(rom1, rom2));
    }

    @Test
    public void testParamManagerDetection() {
        String extra = "-machine q35 -cpu Penryn,vendor=GenuineIntel,+ssse3,+sse4.2,+popcnt,+avx,+aes,+xsave,+xsaveopt,check -device isa-applesmc,osk=\"ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc\" -smbios type=2";
        assertTrue(ParamManager.hasMachine(extra));
        assertTrue(ParamManager.hasCpu(extra));
        assertTrue(extra.contains("isa-applesmc"));
        assertTrue(extra.contains("smbios type=2"));
    }
}
