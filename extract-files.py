#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import (
    lib_fixups,
    lib_fixups_user_type,
)
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'device/lge/timelm',
    'hardware/lge',
    'vendor/qcom/common/vendor/dsprpcd',
    'vendor/qcom/common/vendor/display/4.19',
    'vendor/qcom/common/vendor/perf',
    'vendor/qcom/common/vendor/qseecomd-legacy',
    'vendor/qcom/common/vendor/adreno/r',
    'vendor/qcom/common/vendor/media/legacy',
    'vendor/qcom/common/vendor/gps-legacy',
    'vendor/qcom/common/vendor/display',
    'vendor/qcom/common/system/display',
#    'hardware/qcom-caf/common/libqti-perfd-client',
#    'hardware/qcom-caf/sm8250',
#    'hardware/qcom-caf/wlan',
#    'vendor/qcom/opensource/commonsys-intf/display',
#    'vendor/qcom/opensource/commonsys/display',
#    'vendor/qcom/opensource/dataservices',
#    'vendor/qcom/opensource/display',
]

def lib_fixup_vendor_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_vendor' if partition in ['odm', 'vendor'] else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'com.qti.stats.pdlib',
        'com.qualcomm.qti.dpm.api@1.0',
        'com.qualcomm.qti.imscmservice@2.0',
        'com.qualcomm.qti.imscmservice@2.1',
        'com.qualcomm.qti.imscmservice@2.2',
        'com.qualcomm.qti.uceservice@2.0',
        'com.qualcomm.qti.uceservice@2.1',
        'com.qualcomm.qti.uceservice@2.2',
        'com.qualcomm.qti.uceservice@2.3',
        'libmmosal',
        'vendor.qti.data.factory@2.0',
        'vendor.qti.data.factory@2.1',
        'vendor.qti.data.factory@2.2',
        'vendor.qti.data.factory@2.3',
        'vendor.qti.data.mwqem@1.0',
        'vendor.qti.data.slm@1.0',
        'vendor.qti.hardware.data.cne.internal.api@1.0',
        'vendor.qti.hardware.data.cne.internal.constants@1.0',
        'vendor.qti.hardware.data.cne.internal.server@1.0',
        'vendor.qti.hardware.data.connection@1.0',
        'vendor.qti.hardware.data.connection@1.1',
        'vendor.qti.hardware.data.dynamicdds@1.0',
        'vendor.qti.hardware.data.iwlan@1.0',
        'vendor.qti.hardware.data.latency@1.0',
        'vendor.qti.hardware.data.lce@1.0',
        'vendor.qti.hardware.data.qmi@1.0',
        'vendor.qti.hardware.embmssl@1.0',
        'vendor.qti.hardware.embmssl@1.1',
        'vendor.qti.hardware.mwqemadapter@1.0',
        'vendor.qti.hardware.radio.am@1.0',
        'vendor.qti.hardware.radio.atcmdfwd@1.0',
        'vendor.qti.hardware.radio.ims@1.0',
        'vendor.qti.hardware.radio.ims@1.1',
        'vendor.qti.hardware.radio.ims@1.2',
        'vendor.qti.hardware.radio.ims@1.3',
        'vendor.qti.hardware.radio.ims@1.4',
        'vendor.qti.hardware.radio.ims@1.5',
        'vendor.qti.hardware.radio.ims@1.6',
        'vendor.qti.hardware.radio.ims@1.7',
        'vendor.qti.hardware.radio.internal.deviceinfo@1.0',
        'vendor.qti.hardware.radio.lpa@1.0',
        'vendor.qti.hardware.radio.lpa@1.1',
        'vendor.qti.hardware.radio.lpa@1.2',
        'vendor.qti.hardware.radio.qcrilhook@1.0',
        'vendor.qti.hardware.radio.qtiradio@1.0',
        'vendor.qti.hardware.radio.qtiradio@2.0',
        'vendor.qti.hardware.radio.qtiradio@2.1',
        'vendor.qti.hardware.radio.qtiradio@2.2',
        'vendor.qti.hardware.radio.qtiradio@2.3',
        'vendor.qti.hardware.radio.qtiradio@2.4',
        'vendor.qti.hardware.radio.qtiradio@2.5',
        'vendor.qti.hardware.radio.qtiradio@2.6',
        'vendor.qti.hardware.radio.uim@1.0',
        'vendor.qti.hardware.radio.uim@1.1',
        'vendor.qti.hardware.radio.uim@1.2',
        'vendor.qti.hardware.radio.uim_remote_client@1.0',
        'vendor.qti.hardware.radio.uim_remote_client@1.1',
        'vendor.qti.hardware.radio.uim_remote_client@1.2',
        'vendor.qti.hardware.radio.uim_remote_server@1.0',
        'vendor.qti.hardware.slmadapter@1.0',
        'vendor.qti.ims.callcapability@1.0',
        'vendor.qti.ims.callinfo@1.0',
        'vendor.qti.ims.factory@1.0',
        'vendor.qti.ims.factory@1.1',
        'vendor.qti.ims.rcsconfig@1.0',
        'vendor.qti.ims.rcsconfig@1.1',
        'vendor.qti.ims.rcsconfig@2.0',
        'vendor.qti.ims.rcsconfig@2.1',
        'vendor.qti.imsrtpservice@3.0',
        'vendor.qti.latency@2.0',
        'vendor.qti.latency@2.1',
    ): lib_fixup_vendor_suffix,
}

def lib_fixup_system_ext_suffix(lib: str, partition: str, *args, **kwargs):
    return f'{lib}_system_ext' if partition in ['system_ext'] else None

lib_fixups: lib_fixups_user_type = {
    **lib_fixups,
    (
        'libarcsoft_beauty_picselfie',
        'libarcsoft_dualcam_portraitlighting',
        'libarcsoft_dualcam_refocus',
        'libarcsoft_dualcam_refocus_front',
        'libarcsoft_dualcam_refocus_rear_t',
        'libarcsoft_makeup',
        'libarcsoft_picselfie_algorithm',
        'libarcsoft_singlecam_portrait_lighting',
        'libcvp2',
        'libcvp2_hfi',
        'libcvp_common',
        'libdepthmapdecoder.arcsoft',
        'liblghdri',
        'libmorpho_image_stab31',
        'libmpbase',
        'libSRIyuv',
        'vendor.lge.hardware.vss_ims@1.0',
    ): lib_fixup_system_ext_suffix,
}

blob_fixups: blob_fixups_user_type = {
    'vendor/etc/init/vendor.sensors.sscrpcd.rc': blob_fixup()
        .regex_replace('class early_hal', 'class core'),
    'vendor/lib64/liblgdnnsnpe.so': blob_fixup()
        .replace_needed('libstdc++.so', 'libstdc++_vendor.so'),
    'vendor/lib64/libimagerwrapper.so': blob_fixup()
        .add_needed('liblog.so'),
    'vendor/lib64/libwvhidl.so': blob_fixup()
        .add_needed('libcrypto_shim.so'),
    'vendor/lib64/libril-qc-hal-qmi.so': blob_fixup()
	    .replace_needed('vendor.lge.hardware.radio@2.0.so', 'vendor.lge.hardware.radio@2.0_vendor.so'),
    'vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so': blob_fixup()
	    .sig_replace('9A 0A 00 94', 'E0 03 00 AA'),
    'vendor/lib/libqcodec2_v4l2codec.so': blob_fixup()
        .sig_replace(
            '0A 0A 08 21 F7 EE C0 0A 70 EE 88 0B BC EE E0 0B 10 EE 10 0A 61 F3 1F',
            '0A 0A 08 21 F7 EE C0 0A C0 EE A1 0B BC EE 60 0B 10 EE 10 0A 61 F3 1F',
        ),
    'vendor/lib64/camera/components/com.qti.stats.afd.so': (
        blob_fixup()
            .sig_replace('00 32 F9 03 00 32 E2 04 00 94 2C 00', '00 32 F9 03 1F 2A E2 04 00 94 2C 00')
            .sig_replace('00 37 F9 03 00 32 C0 FF FF 17 64 07', '00 37 F9 03 1F 2A C0 FF FF 17 64 07')
    ),
    'vendor/lib64/libdpps.so': blob_fixup()
        .replace_needed('libtinyxml2.so', 'libtinyxml2-v34.so'),
    'vendor/lib64/libets_teeclient_v2.so': (
        blob_fixup()
            .remove_needed('libfpsph.so')
            .add_needed('libets_teeclient_v2_shim.so')
    ),
    'system_ext/lib64/libims.lge.so': (
        blob_fixup()
            .add_needed('libbinder_ims.so')
            .add_needed('libutils_ims.so')
    ),
    'system_ext/lib64/libimscamerajni.lge.so': (
        blob_fixup()
            .add_needed('libbinder_ims.so')
            .add_needed('libutils_ims.so')
            .add_needed('libgui_ims.so')
    ),
    'system_ext/lib64/libimsmmpf.lge.so': (
        blob_fixup()
            .add_needed('libhidlbase_ims.so')
            .add_needed('libhidltransport_ims.so')
            .add_needed('libmedia_ims.so')
            .add_needed('libui_ims.so')
            .add_needed('libgui_ims.so')
    ),
    'system_ext/lib64/libimswms.lge.so': (
        blob_fixup()
            .add_needed('libutils_ims.so')
            .add_needed('libhidlbase_ims.so')
            .add_needed('libhidltransport_ims.so')
    ),
}  # fmt: skip

module = ExtractUtilsModule(
    'timelm',
    'lge',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
)

if __name__ == '__main__':
    utils = ExtractUtils.device(module)
    utils.run()
