package com.VirtuMuse.VirtuMuse

import com.appsflyerext.ext.AFApp
import com.appsflyerext.ext.Conf
import com.appsflyerext.ext.Device

class App : AFApp() {
    override val conf: Conf
        get() = Conf(
            afKey = "8MazMv7PCdv2ajzGMYXPNi",
            host = "",
            afSPName = "_cz_a_",
            afStatusKey = "_cz_ka_",
            debug = true,
            device = Device(this),
            key = "cz",
        )
}