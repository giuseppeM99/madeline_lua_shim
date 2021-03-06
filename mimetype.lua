local mimetype = {}

local types = {
  ['audio/x-ms-wma'] = 'wma',
  ['application/vnd.cosmocaller'] = 'cmc',
  ['text/csv'] = 'csv',
  ['application/vnd.dolby.mlp'] = 'mlp',
  ['image/vnd.fujixerox.edmics-mmr'] = 'mmr',
  ['application/vnd.picsel'] = 'efif',
  ['application/pkcs10'] = 'p10',
  ['application/winhlp'] = 'hlp',
  ['application/sru+xml'] = 'sru',
  ['video/mpeg'] = 'm2v',
  ['application/vnd.clonk.c4group'] = 'c4u',
  ['application/vnd.handheld-entertainment+xml'] = 'zmm',
  ['application/vnd.noblenet-directory'] = 'nnd',
  ['application/vnd.dart'] = 'dart',
  ['application/x-pkcs7-certificates'] = 'spc',
  ['application/vnd.kde.kontour'] = 'kon',
  ['application/vnd.mophun.certificate'] = 'mpc',
  ['application/vnd.acucorp'] = 'acutc',
  ['application/vnd.sema'] = 'sema',
  ['application/x-zmachine'] = 'z3',
  ['application/gxf'] = 'gxf',
  ['model/vnd.gtw'] = 'gtw',
  ['application/vnd.frogans.fnc'] = 'fnc',
  ['audio/x-pn-realaudio-plugin'] = 'rmp',
  ['application/vnd.publishare-delta-tree'] = 'qps',
  ['application/vnd.ms-powerpoint'] = 'pps',
  ['application/vnd.las.las+xml'] = 'lasxml',
  ['application/vnd.tmobile-livetv'] = 'tmo',
  ['application/mxf'] = 'mxf',
  ['application/vnd.rn-realmedia'] = 'rm',
  ['application/vnd.ms-powerpoint.slideshow.macroenabled.12'] = 'ppsm',
  ['application/vnd.ms-xpsdocument'] = 'xps',
  ['video/x-ms-wm'] = 'wm',
  ['model/x3d+vrml'] = 'x3dvz',
  ['application/x-msclip'] = 'clp',
  ['application/vnd.geoplan'] = 'g2w',
  ['application/inkml+xml'] = 'inkml',
  ['application/vnd.palm'] = 'oprc',
  ['application/postscript'] = 'eps',
  ['application/vnd.dece.unspecified'] = 'uvvx',
  ['application/x-authorware-bin'] = 'u32',
  ['application/x-chat'] = 'chat',
  ['application/vnd.hp-hps'] = 'hps',
  ['application/vnd.osgi.dp'] = 'dp',
  ['application/vnd.rim.cod'] = 'cod',
  ['application/vnd.nokia.n-gage.symbian.install'] = 'n-gage',
  ['application/vnd.ms-wpl'] = 'wpl',
  ['application/vnd.ms-powerpoint.presentation.macroenabled.12'] = 'pptm',
  ['application/vnd.jcp.javame.midlet-rms'] = 'rms',
  ['application/x-futuresplash'] = 'spl',
  ['application/msword'] = 'doc',
  ['application/mp4'] = 'mp4s',
  ['application/vnd.wordperfect'] = 'wpd',
  ['application/vnd.kinar'] = 'knp',
  ['application/vnd.mediastation.cdkey'] = 'cdkey',
  ['audio/x-wav'] = 'wav',
  ['audio/mpeg'] = 'mp2',
  ['application/vnd.yellowriver-custom-menu'] = 'cmp',
  ['application/vnd.tcpdump.pcap'] = 'dmp',
  ['application/x-wais-source'] = 'src',
  ['application/vnd.cups-ppd'] = 'ppd',
  ['image/svg+xml'] = 'svg',
  ['application/vnd.is-xpr'] = 'xpr',
  ['application/postscript'] = 'ps',
  ['application/octet-stream'] = 'dms',
  ['image/vnd.dece.graphic'] = 'uvg',
  ['application/onenote'] = 'onetoc',
  ['application/x-mobipocket-ebook'] = 'prc',
  ['application/javascript'] = 'js',
  ['application/vnd.ms-ims'] = 'ims',
  ['application/vnd.macports.portpkg'] = 'portpkg',
  ['application/vnd.android.package-archive'] = 'apk',
  ['image/svg+xml'] = 'svgz',
  ['application/metalink+xml'] = 'metalink',
  ['application/vnd.kde.kpresenter'] = 'kpr',
  ['application/vnd.oasis.opendocument.text-template'] = 'ott',
  ['application/vnd.shana.informed.package'] = 'ipk',
  ['application/xspf+xml'] = 'xspf',
  ['image/x-xpixmap'] = 'xpm',
  ['application/ecmascript'] = 'ecma',
  ['application/vnd.wqd'] = 'wqd',
  ['image/x-cmx'] = 'cmx',
  ['application/vnd.dece.zip'] = 'uvvz',
  ['application/x-director'] = 'cst',
  ['application/vnd.micrografx.flo'] = 'flo',
  ['application/vnd.groove-injector'] = 'grv',
  ['application/vnd.airzip.filesecure.azf'] = 'azf',
  ['application/ipfix'] = 'ipfix',
  ['video/x-ms-wvx'] = 'wvx',
  ['video/jpm'] = 'jpm',
  ['application/vnd.lotus-approach'] = 'apr',
  ['model/vrml'] = 'wrl',
  ['application/srgs'] = 'gram',
  ['application/x-pkcs12'] = 'p12',
  ['video/vnd.uvvu.mp4'] = 'uvu',
  ['application/vnd.pvi.ptid1'] = 'ptid',
  ['text/css'] = 'css',
  ['x-conference/x-cooltalk'] = 'ice',
  ['audio/vnd.dece.audio'] = 'uvva',
  ['video/x-smv'] = 'smv',
  ['application/vnd.palm'] = 'pqa',
  ['video/x-sgi-movie'] = 'movie',
  ['application/vnd.sun.xml.calc.template'] = 'stc',
  ['video/x-msvideo'] = 'avi',
  ['application/yang'] = 'yang',
  ['application/vnd.ibm.modcap'] = 'list3820',
  ['application/pkix-crl'] = 'crl',
  ['application/vnd.visio'] = 'vss',
  ['application/vnd.ms-word.template.macroenabled.12'] = 'dotm',
  ['video/x-ms-wmx'] = 'wmx',
  ['application/lost+xml'] = 'lostxml',
  ['application/rss+xml'] = 'rss',
  ['application/vnd.ms-project'] = 'mpp',
  ['application/x-mscardfile'] = 'crd',
  ['application/vnd.flographit'] = 'gph',
  ['application/vnd.symbian.install'] = 'sisx',
  ['application/vnd.olpc-sugar'] = 'xo',
  ['model/vrml'] = 'vrml',
  ['application/vnd.wap.wmlc'] = 'wmlc',
  ['video/x-ms-asf'] = 'asf',
  ['application/vnd.ms-lrm'] = 'lrm',
  ['application/vnd.trueapp'] = 'tra',
  ['video/x-mng'] = 'mng',
  ['video/h263'] = 'h263',
  ['text/troff'] = 't',
  ['application/vnd.lotus-1-2-3'] = '123',
  ['application/vnd.mophun.application'] = 'mpn',
  ['application/vnd.clonk.c4group'] = 'c4d',
  ['application/x-msterminal'] = 'trm',
  ['application/timestamped-data'] = 'tsd',
  ['application/x-freearc'] = 'arc',
  ['application/srgs+xml'] = 'grxml',
  ['video/x-matroska'] = 'mk3d',
  ['video/x-matroska'] = 'mkv',
  ['video/x-m4v'] = 'm4v',
  ['application/vnd.ms-excel.sheet.macroenabled.12'] = 'xlsm',
  ['video/x-flv'] = 'flv',
  ['application/set-registration-initiation'] = 'setreg',
  ['application/vnd.sailingtracker.track'] = 'st',
  ['video/x-fli'] = 'fli',
  ['video/quicktime'] = 'qt',
  ['application/oxps'] = 'oxps',
  ['application/vnd.dece.zip'] = 'uvz',
  ['application/mp21'] = 'm21',
  ['application/vnd.mobius.msl'] = 'msl',
  ['application/x-dvi'] = 'dvi',
  ['application/sbml+xml'] = 'sbml',
  ['application/x-zmachine'] = 'z2',
  ['video/x-f4v'] = 'f4v',
  ['application/vnd.ibm.rights-management'] = 'irm',
  ['application/vnd.eszigno3+xml'] = 'es3',
  ['application/vnd.ms-officetheme'] = 'thmx',
  ['model/vnd.vtu'] = 'vtu',
  ['application/mads+xml'] = 'mads',
  ['application/vnd.fsc.weblaunch'] = 'fsc',
  ['application/vnd.3gpp.pic-bw-small'] = 'psb',
  ['application/xaml+xml'] = 'xaml',
  ['application/vnd.ibm.modcap'] = 'afp',
  ['video/vnd.vivo'] = 'viv',
  ['application/vnd.sun.xml.draw.template'] = 'std',
  ['application/x-msmediaview'] = 'm13',
  ['text/x-fortran'] = 'f',
  ['application/x-iso9660-image'] = 'iso',
  ['application/vnd.mseq'] = 'mseq',
  ['video/vnd.uvvu.mp4'] = 'uvvu',
  ['application/vnd.grafeq'] = 'gqf',
  ['application/vnd.ms-fontobject'] = 'eot',
  ['application/msword'] = 'dot',
  ['application/vnd.geospace'] = 'g3w',
  ['application/atomsvc+xml'] = 'atomsvc',
  ['application/vnd.irepository.package+xml'] = 'irp',
  ['video/vnd.ms-playready.media.pyv'] = 'pyv',
  ['text/x-asm'] = 'asm',
  ['video/vnd.mpegurl'] = 'm4u',
  ['application/x-font-snf'] = 'snf',
  ['video/vnd.mpegurl'] = 'mxu',
  ['application/x-pkcs7-certificates'] = 'p7b',
  ['video/vnd.fvt'] = 'fvt',
  ['application/x-zmachine'] = 'z1',
  ['application/vnd.ms-powerpoint'] = 'pot',
  ['application/x-lzh-compressed'] = 'lzh',
  ['application/vnd.dvb.service'] = 'svc',
  ['application/vnd.trid.tpt'] = 'tpt',
  ['application/vnd.eszigno3+xml'] = 'et3',
  ['application/vnd.dpgraph'] = 'dpg',
  ['video/vnd.dvb.file'] = 'dvb',
  ['application/x-t3vm-image'] = 't3',
  ['application/vnd.mozilla.xul+xml'] = 'xul',
  ['application/sparql-results+xml'] = 'srx',
  ['application/vnd.openxmlformats-officedocument.spreadsheetml.template'] = 'xltx',
  ['application/x-dtbook+xml'] = 'dtb',
  ['application/vnd.sus-calendar'] = 'susp',
  ['image/jpeg'] = 'jpe',
  ['video/vnd.dece.video'] = 'uvvv',
  ['video/vnd.dece.video'] = 'uvv',
  ['video/vnd.dece.sd'] = 'uvvs',
  ['application/tei+xml'] = 'teicorpus',
  ['application/vnd.unity'] = 'unityweb',
  ['application/vnd.immervision-ivu'] = 'ivu',
  ['application/x-envoy'] = 'evy',
  ['application/vnd.ms-pki.stl'] = 'stl',
  ['video/vnd.dece.pd'] = 'uvvp',
  ['text/x-c'] = 'cxx',
  ['text/vnd.curl.dcurl'] = 'dcurl',
  ['video/vnd.dece.mobile'] = 'uvvm',
  ['application/vnd.kde.kspread'] = 'ksp',
  ['application/vnd.kahootz'] = 'ktr',
  ['application/vnd.ms-project'] = 'mpt',
  ['video/mj2'] = 'mjp2',
  ['text/x-sfv'] = 'sfv',
  ['application/vnd.ms-powerpoint'] = 'ppt',
  ['application/x-gnumeric'] = 'gnumeric',
  ['video/vnd.dece.hd'] = 'uvvh',
  ['application/x-zmachine'] = 'z4',
  ['application/metalink4+xml'] = 'meta4',
  ['application/vnd.cluetrust.cartomobile-config-pkg'] = 'c11amz',
  ['video/vnd.dece.hd'] = 'uvh',
  ['application/vnd.crick.clicker.keyboard'] = 'clkk',
  ['video/ogg'] = 'ogv',
  ['application/x-xliff+xml'] = 'xlf',
  ['video/mpeg'] = 'mpe',
  ['application/x-sh'] = 'sh',
  ['application/pkix-cert'] = 'cer',
  ['video/mpeg'] = 'mpg',
  ['image/x-freehand'] = 'fh',
  ['application/vnd.3m.post-it-notes'] = 'pwn',
  ['video/mpeg'] = 'mpeg',
  ['model/vnd.collada+xml'] = 'dae',
  ['application/vnd.oasis.opendocument.graphics'] = 'odg',
  ['model/x3d+vrml'] = 'x3dv',
  ['application/vnd.kde.karbon'] = 'karbon',
  ['application/vnd.shana.informed.formtemplate'] = 'itp',
  ['application/x-sv4crc'] = 'sv4crc',
  ['video/mp4'] = 'mp4v',
  ['image/x-pcx'] = 'pcx',
  ['application/vnd.hp-pclxl'] = 'pclxl',
  ['application/x-dtbncx+xml'] = 'ncx',
  ['application/x-font-pcf'] = 'pcf',
  ['video/mp4'] = 'mp4',
  ['application/vnd.sus-calendar'] = 'sus',
  ['text/x-nfo'] = 'nfo',
  ['application/vnd.oasis.opendocument.presentation-template'] = 'otp',
  ['application/vnd.realvnc.bed'] = 'bed',
  ['application/x-gtar'] = 'gtar',
  ['video/jpeg'] = 'jpgv',
  ['application/smil+xml'] = 'smi',
  ['video/h261'] = 'h261',
  ['application/vnd.stardivision.writer-global'] = 'sgl',
  ['text/x-fortran'] = 'f77',
  ['application/vnd.llamagraphics.life-balance.exchange+xml'] = 'lbe',
  ['application/emma+xml'] = 'emma',
  ['application/x-msmoney'] = 'mny',
  ['application/font-tdpfr'] = 'pfr',
  ['text/uri-list'] = 'urls',
  ['text/x-vcalendar'] = 'vcs',
  ['application/vnd.dvb.ait'] = 'ait',
  ['text/x-uuencode'] = 'uu',
  ['application/vnd.igloader'] = 'igl',
  ['video/vnd.dece.mobile'] = 'uvm',
  ['text/x-setext'] = 'etx',
  ['text/troff'] = 'me',
  ['text/x-pascal'] = 'pas',
  ['text/x-pascal'] = 'p',
  ['text/x-opml'] = 'opml',
  ['application/onenote'] = 'onepkg',
  ['video/jpm'] = 'jpgm',
  ['application/x-font-type1'] = 'pfa',
  ['text/x-java-source'] = 'java',
  ['text/calendar'] = 'ifb',
  ['text/x-fortran'] = 'f90',
  ['application/vnd.ms-excel.addin.macroenabled.12'] = 'xlam',
  ['application/x-ustar'] = 'ustar',
  ['application/vnd.novadigm.edx'] = 'edx',
  ['application/vnd.adobe.xfdf'] = 'xfdf',
  ['application/xv+xml'] = 'xvml',
  ['application/x-font-type1'] = 'pfb',
  ['video/3gpp2'] = '3g2',
  ['text/x-fortran'] = 'for',
  ['text/x-c'] = 'dic',
  ['application/vnd.framemaker'] = 'book',
  ['application/x-dtbresource+xml'] = 'res',
  ['text/x-c'] = 'hh',
  ['text/x-c'] = 'h',
  ['application/vnd.koan'] = 'skt',
  ['text/x-c'] = 'cpp',
  ['video/vnd.dece.pd'] = 'uvp',
  ['application/vnd.hhe.lesson-player'] = 'les',
  ['application/x-ace-compressed'] = 'ace',
  ['application/x-tex'] = 'tex',
  ['text/x-c'] = 'cc',
  ['text/x-c'] = 'c',
  ['application/vnd.vcx'] = 'vcx',
  ['application/vnd.fujitsu.oasysprs'] = 'bh2',
  ['application/vnd.seemail'] = 'see',
  ['application/vnd.yamaha.hv-voice'] = 'hvp',
  ['application/x-dgc-compressed'] = 'dgc',
  ['application/pkcs7-mime'] = 'p7m',
  ['application/vnd.immervision-ivp'] = 'ivp',
  ['image/vnd.net-fpx'] = 'npx',
  ['text/vnd.sun.j2me.app-descriptor'] = 'jad',
  ['audio/ogg'] = 'oga',
  ['application/vnd.geogebra.file'] = 'ggb',
  ['text/vnd.in3d.spot'] = 'spot',
  ['application/vnd.openxmlformats-officedocument.presentationml.presentation'] = 'pptx',
  ['application/x-director'] = 'fgd',
  ['text/vnd.graphviz'] = 'gv',
  ['audio/vnd.lucent.voice'] = 'lvp',
  ['application/vnd.geometry-explorer'] = 'gex',
  ['text/vnd.fmi.flexstor'] = 'flx',
  ['chemical/x-csml'] = 'csml',
  ['application/vnd.adobe.fxp'] = 'fxpl',
  ['application/vnd.ms-excel'] = 'xlt',
  ['application/vnd.oasis.opendocument.image-template'] = 'oti',
  ['application/vnd.amazon.ebook'] = 'azw',
  ['application/vnd.epson.salt'] = 'slt',
  ['text/vnd.curl.scurl'] = 'scurl',
  ['application/vnd.sun.xml.impress.template'] = 'sti',
  ['application/vnd.clonk.c4group'] = 'c4p',
  ['image/x-mrsid-image'] = 'sid',
  ['text/vnd.curl.mcurl'] = 'mcurl',
  ['application/x-lzh-compressed'] = 'lha',
  ['image/x-tga'] = 'tga',
  ['application/vnd.denovo.fcselayout-link'] = 'fe_launch',
  ['text/x-vcard'] = 'vcf',
  ['text/html'] = 'html',
  ['text/uri-list'] = 'uris',
  ['application/vnd.kahootz'] = 'ktz',
  ['application/vnd.jisp'] = 'jisp',
  ['application/x-cfs-compressed'] = 'cfs',
  ['application/vnd.hp-jlyt'] = 'jlt',
  ['text/uri-list'] = 'uri',
  ['text/turtle'] = 'ttl',
  ['text/troff'] = 'ms',
  ['text/plain'] = 'text',
  ['application/java-serialized-object'] = 'ser',
  ['audio/mpeg'] = 'mpga',
  ['application/vnd.uiq.theme'] = 'utz',
  ['application/vnd.anser-web-funds-transfer-initiation'] = 'fti',
  ['text/troff'] = 'roff',
  ['application/vnd.lotus-wordpro'] = 'lwp',
  ['text/troff'] = 'tr',
  ['application/patch-ops-error+xml'] = 'xer',
  ['model/vnd.dwf'] = 'dwf',
  ['application/vnd.mobius.plc'] = 'plc',
  ['application/ssml+xml'] = 'ssml',
  ['image/vnd.fujixerox.edmics-rlc'] = 'rlc',
  ['application/x-director'] = 'dir',
  ['application/vnd.google-earth.kmz'] = 'kmz',
  ['video/x-matroska'] = 'mks',
  ['text/tab-separated-values'] = 'tsv',
  ['application/vnd.ms-works'] = 'wks',
  ['application/vnd.amiga.ami'] = 'ami',
  ['video/mj2'] = 'mj2',
  ['application/vnd.kidspiration'] = 'kia',
  ['application/xcap-diff+xml'] = 'xdf',
  ['application/resource-lists+xml'] = 'rl',
  ['application/vnd.bmi'] = 'bmi',
  ['application/x-shockwave-flash'] = 'swf',
  ['text/sgml'] = 'sgml',
  ['application/vnd.openxmlformats-officedocument.presentationml.template'] = 'potx',
  ['application/vnd.stepmania.stepchart'] = 'sm',
  ['application/vnd.ms-artgalry'] = 'cil',
  ['application/vnd.umajin'] = 'umj',
  ['text/prs.lines.tag'] = 'dsc',
  ['application/set-payment-initiation'] = 'setpay',
  ['application/vnd.sun.xml.writer.global'] = 'sxg',
  ['text/plain'] = 'in',
  ['application/octet-stream'] = 'dist',
  ['application/json'] = 'json',
  ['application/vnd.adobe.air-application-installer-package+zip'] = 'air',
  ['text/plain'] = 'log',
  ['application/vnd.openxmlformats-officedocument.wordprocessingml.template'] = 'dotx',
  ['audio/midi'] = 'rmi',
  ['application/vnd.adobe.fxp'] = 'fxp',
  ['application/pls+xml'] = 'pls',
  ['application/x-netcdf'] = 'cdf',
  ['application/x-font-bdf'] = 'bdf',
  ['text/plain'] = 'list',
  ['text/plain'] = 'def',
  ['audio/ogg'] = 'spx',
  ['application/x-msdownload'] = 'com',
  ['application/vnd.clonk.c4group'] = 'c4f',
  ['application/vnd.ms-excel'] = 'xls',
  ['application/vnd.previewsystems.box'] = 'box',
  ['application/vnd.koan'] = 'skd',
  ['text/n3'] = 'n3',
  ['text/html'] = 'htm',
  ['text/calendar'] = 'ics',
  ['image/jpeg'] = 'jpeg',
  ['model/x3d+xml'] = 'x3dz',
  ['model/x3d+xml'] = 'x3d',
  ['application/rpki-manifest'] = 'mft',
  ['application/rdf+xml'] = 'rdf',
  ['video/mp4'] = 'mpg4',
  ['application/vnd.framemaker'] = 'frame',
  ['application/vnd.oasis.opendocument.formula'] = 'odf',
  ['image/vnd.fpx'] = 'fpx',
  ['image/x-portable-anymap'] = 'pnm',
  ['model/x3d+binary'] = 'x3db',
  ['application/vnd.openxmlformats-officedocument.presentationml.slideshow'] = 'ppsx',
  ['video/x-ms-vob'] = 'vob',
  ['model/vnd.mts'] = 'mts',
  ['application/x-hdf'] = 'hdf',
  ['application/vnd.openxmlformats-officedocument.wordprocessingml.document'] = 'docx',
  ['application/vnd.fdf'] = 'fdf',
  ['model/vnd.gdl'] = 'gdl',
  ['model/mesh'] = 'silo',
  ['application/x-research-info-systems'] = 'ris',
  ['model/mesh'] = 'mesh',
  ['application/sparql-query'] = 'rq',
  ['model/iges'] = 'iges',
  ['model/iges'] = 'igs',
  ['message/rfc822'] = 'mime',
  ['application/xenc+xml'] = 'xenc',
  ['image/ief'] = 'ief',
  ['image/x-xwindowdump'] = 'xwd',
  ['application/resource-lists-diff+xml'] = 'rld',
  ['application/x-msaccess'] = 'mdb',
  ['application/widget'] = 'wgt',
  ['application/vnd.visionary'] = 'vis',
  ['application/vnd.ms-excel.template.macroenabled.12'] = 'xltm',
  ['audio/x-matroska'] = 'mka',
  ['application/vnd.dece.data'] = 'uvf',
  ['application/mac-binhex40'] = 'hqx',
  ['application/vnd.ms-powerpoint.slide.macroenabled.12'] = 'sldm',
  ['text/vnd.curl'] = 'curl',
  ['application/scvp-vp-request'] = 'spq',
  ['image/x-rgb'] = 'rgb',
  ['application/relax-ng-compact-syntax'] = 'rnc',
  ['application/marcxml+xml'] = 'mrcx',
  ['image/x-portable-pixmap'] = 'ppm',
  ['application/vnd.gmx'] = 'gmx',
  ['application/vnd.hydrostatix.sof-data'] = 'sfd-hdstx',
  ['image/x-portable-bitmap'] = 'pbm',
  ['application/vnd.geogebra.tool'] = 'ggt',
  ['audio/x-aiff'] = 'aifc',
  ['model/x3d+binary'] = 'x3dbz',
  ['application/postscript'] = 'ai',
  ['application/vnd.claymore'] = 'cla',
  ['application/vnd.enliven'] = 'nml',
  ['audio/mpeg'] = 'm2a',
  ['application/vnd.ctc-posml'] = 'pml',
  ['image/x-pict'] = 'pic',
  ['image/x-icon'] = 'ico',
  ['application/vnd.groove-vcard'] = 'vcg',
  ['application/x-msmediaview'] = 'm14',
  ['application/octet-stream'] = 'so',
  ['application/vnd.cluetrust.cartomobile-config'] = 'c11amc',
  ['application/vnd.apple.mpegurl'] = 'm3u8',
  ['application/ogg'] = 'ogx',
  ['application/vnd.google-earth.kml+xml'] = 'kml',
  ['image/x-freehand'] = 'fh4',
  ['application/vnd.kde.kchart'] = 'chrt',
  ['image/x-freehand'] = 'fhc',
  ['image/x-cmu-raster'] = 'ras',
  ['image/x-3ds'] = '3ds',
  ['application/vnd.rig.cryptonote'] = 'cryptonote',
  ['application/vnd.chipnuts.karaoke-mmd'] = 'mmd',
  ['application/octet-stream'] = 'elc',
  ['image/webp'] = 'webp',
  ['application/hyperstudio'] = 'stk',
  ['image/vnd.wap.wbmp'] = 'wbmp',
  ['text/vnd.wap.wml'] = 'wml',
  ['application/voicexml+xml'] = 'vxml',
  ['application/vnd.3gpp.pic-bw-large'] = 'plb',
  ['application/vnd.ms-excel'] = 'xla',
  ['application/vnd.pawaafile'] = 'paw',
  ['image/vnd.ms-photo'] = 'wdp',
  ['application/vnd.dna'] = 'dna',
  ['image/vnd.fst'] = 'fst',
  ['image/vnd.fastbidsheet'] = 'fbs',
  ['image/vnd.dxf'] = 'dxf',
  ['image/vnd.dwg'] = 'dwg',
  ['application/rpki-roa'] = 'roa',
  ['image/vnd.djvu'] = 'djv',
  ['image/vnd.djvu'] = 'djvu',
  ['image/vnd.dece.graphic'] = 'uvvg',
  ['image/vnd.dece.graphic'] = 'uvvi',
  ['image/vnd.dece.graphic'] = 'uvi',
  ['application/vnd.dece.ttml+xml'] = 'uvvt',
  ['image/vnd.adobe.photoshop'] = 'psd',
  ['image/tiff'] = 'tif',
  ['image/tiff'] = 'tiff',
  ['image/sgi'] = 'sgi',
  ['application/vnd.acucobol'] = 'acu',
  ['application/vnd.blueice.multipass'] = 'mpm',
  ['application/x-apple-diskimage'] = 'dmg',
  ['image/png'] = 'png',
  ['image/ktx'] = 'ktx',
  ['image/jpeg'] = 'jpg',
  ['chemical/x-cml'] = 'cml',
  ['text/cache-manifest'] = 'appcache',
  ['message/rfc822'] = 'eml',
  ['application/x-cbr'] = 'cb7',
  ['application/vnd.mobius.dis'] = 'dis',
  ['application/mbox'] = 'mbox',
  ['image/g3fax'] = 'g3',
  ['application/vnd.fujitsu.oasys3'] = 'oa3',
  ['image/bmp'] = 'bmp',
  ['application/vnd.ms-pki.seccat'] = 'cat',
  ['application/x-msdownload'] = 'bat',
  ['chemical/x-xyz'] = 'xyz',
  ['text/vnd.fly'] = 'fly',
  ['application/vnd.stardivision.writer'] = 'sdw',
  ['image/vnd.xiff'] = 'xif',
  ['chemical/x-cif'] = 'cif',
  ['chemical/x-cdx'] = 'cdx',
  ['audio/xm'] = 'xm',
  ['application/vnd.fujixerox.docuworks'] = 'xdw',
  ['application/x-pkcs7-certreqresp'] = 'p7r',
  ['audio/x-pn-realaudio'] = 'ram',
  ['application/vnd.adobe.formscentral.fcdt'] = 'fcdt',
  ['audio/x-ms-wax'] = 'wax',
  ['audio/x-mpegurl'] = 'm3u',
  ['application/vnd.groove-help'] = 'ghf',
  ['application/vnd.wap.wmlscriptc'] = 'wmlsc',
  ['application/vnd.yamaha.openscoreformat.osfpvg+xml'] = 'osfpvg',
  ['audio/x-caf'] = 'caf',
  ['audio/x-aiff'] = 'aiff',
  ['application/vnd.groove-tool-message'] = 'gtm',
  ['application/inkml+xml'] = 'ink',
  ['application/vnd.semf'] = 'semf',
  ['application/x-stuffitx'] = 'sitx',
  ['application/vnd.rn-realmedia-vbr'] = 'rmvb',
  ['application/xhtml+xml'] = 'xht',
  ['application/x-ms-shortcut'] = 'lnk',
  ['application/shf+xml'] = 'shf',
  ['application/tei+xml'] = 'tei',
  ['audio/vnd.nuera.ecelp9600'] = 'ecelp9600',
  ['application/vnd.noblenet-sealer'] = 'nns',
  ['application/x-cbr'] = 'cbt',
  ['application/vnd.xfdl'] = 'xfdl',
  ['application/x-tgif'] = 'obj',
  ['application/atomcat+xml'] = 'atomcat',
  ['application/x-gramps-xml'] = 'gramps',
  ['audio/vnd.nuera.ecelp4800'] = 'ecelp4800',
  ['application/mods+xml'] = 'mods',
  ['text/vnd.wap.wmlscript'] = 'wmls',
  ['application/x-mobipocket-ebook'] = 'mobi',
  ['audio/vnd.dts.hd'] = 'dtshd',
  ['application/vnd.recordare.musicxml+xml'] = 'musicxml',
  ['audio/vnd.dts'] = 'dts',
  ['application/x-msmetafile'] = 'emf',
  ['audio/vnd.dra'] = 'dra',
  ['audio/vnd.digital-winds'] = 'eol',
  ['audio/vnd.dece.audio'] = 'uva',
  ['application/vnd.dreamfactory'] = 'dfac',
  ['audio/silk'] = 'sil',
  ['audio/s3m'] = 's3m',
  ['audio/basic'] = 'snd',
  ['application/vnd.smaf'] = 'mmf',
  ['audio/mpeg'] = 'm3a',
  ['image/x-pict'] = 'pct',
  ['audio/mpeg'] = 'mp3',
  ['audio/mpeg'] = 'mp2a',
  ['text/troff'] = 'man',
  ['application/x-msdownload'] = 'dll',
  ['application/vnd.smart.teacher'] = 'teacher',
  ['application/vnd.symbian.install'] = 'sis',
  ['audio/mp4'] = 'mp4a',
  ['application/pkixcmp'] = 'pki',
  ['audio/midi'] = 'mid',
  ['audio/ogg'] = 'ogg',
  ['audio/basic'] = 'au',
  ['audio/adpcm'] = 'adp',
  ['application/x-director'] = 'cct',
  ['application/vnd.nokia.radio-preset'] = 'rpst',
  ['application/vnd.ibm.secure-container'] = 'sc',
  ['application/vnd.oasis.opendocument.formula-template'] = 'odft',
  ['application/yin+xml'] = 'yin',
  ['application/vnd.hal+xml'] = 'hal',
  ['application/xv+xml'] = 'xvm',
  ['application/x-netcdf'] = 'nc',
  ['chemical/x-cmdf'] = 'cmdf',
  ['application/xv+xml'] = 'mxml',
  ['application/vnd.pg.osasli'] = 'ei6',
  ['application/xproc+xml'] = 'xpl',
  ['application/xop+xml'] = 'xop',
  ['application/xml-dtd'] = 'dtd',
  ['application/xml'] = 'xsl',
  ['application/xml'] = 'xml',
  ['application/vnd.intu.qfx'] = 'qfx',
  ['application/x-pkcs12'] = 'pfx',
  ['audio/webm'] = 'weba',
  ['application/vnd.oasis.opendocument.text'] = 'odt',
  ['application/xhtml+xml'] = 'xhtml',
  ['application/x-zmachine'] = 'z8',
  ['application/x-zmachine'] = 'z7',
  ['application/x-zmachine'] = 'z6',
  ['application/vnd.crick.clicker'] = 'clkx',
  ['video/h264'] = 'h264',
  ['application/vnd.mobius.mqy'] = 'mqy',
  ['application/x-doom'] = 'wad',
  ['application/x-xpinstall'] = 'xpi',
  ['video/mpeg'] = 'm1v',
  ['application/x-abiword'] = 'abw',
  ['application/cdmi-queue'] = 'cdmiq',
  ['application/x-x509-ca-cert'] = 'crt',
  ['application/vnd.powerbuilder6'] = 'pbd',
  ['application/octet-stream'] = 'mar',
  ['application/x-authorware-bin'] = 'aab',
  ['application/x-msbinder'] = 'obd',
  ['application/vnd.ms-cab-compressed'] = 'cab',
  ['application/x-x509-ca-cert'] = 'der',
  ['application/scvp-cv-response'] = 'scs',
  ['audio/midi'] = 'kar',
  ['application/vnd.oasis.opendocument.chart'] = 'odc',
  ['application/x-texinfo'] = 'texinfo',
  ['application/vnd.wap.wbxml'] = 'wbxml',
  ['application/vnd.jam'] = 'jam',
  ['application/vnd.nitf'] = 'nitf',
  ['application/vnd.wt.stf'] = 'stf',
  ['application/x-bcpio'] = 'bcpio',
  ['application/vnd.curl.car'] = 'car',
  ['application/vnd.epson.quickanime'] = 'qam',
  ['application/vnd.isac.fcs'] = 'fcs',
  ['application/x-tar'] = 'tar',
  ['application/vnd.groove-account'] = 'gac',
  ['application/x-tads'] = 'gam',
  ['application/x-sv4cpio'] = 'sv4cpio',
  ['application/vnd.ecowin.chart'] = 'mag',
  ['application/x-subrip'] = 'srt',
  ['application/vnd.fujixerox.docuworks.binder'] = 'xbd',
  ['audio/x-aac'] = 'aac',
  ['application/x-stuffit'] = 'sit',
  ['application/x-sql'] = 'sql',
  ['application/ccxml+xml'] = 'ccxml',
  ['text/plain'] = 'conf',
  ['application/mac-compactpro'] = 'cpt',
  ['application/x-rar-compressed'] = 'rar',
  ['audio/x-pn-realaudio'] = 'ra',
  ['application/pskc+xml'] = 'pskcxml',
  ['application/x-mswrite'] = 'wri',
  ['application/x-mspublisher'] = 'pub',
  ['application/x-msschedule'] = 'scd',
  ['application/vnd.nokia.n-gage.data'] = 'ngdat',
  ['application/x-msmetafile'] = 'wmf',
  ['application/vnd.tao.intent-module-archive'] = 'tao',
  ['video/3gpp'] = '3gp',
  ['application/x-msmetafile'] = 'emz',
  ['application/rpki-ghostbusters'] = 'gbr',
  ['application/vnd.hp-pcl'] = 'pcl',
  ['application/x-cbr'] = 'cba',
  ['image/x-freehand'] = 'fh7',
  ['application/vnd.mcd'] = 'mcd',
  ['application/x-tcl'] = 'tcl',
  ['application/docbook+xml'] = 'dbk',
  ['application/x-msdownload'] = 'msi',
  ['application/x-silverlight-app'] = 'xap',
  ['audio/midi'] = 'midi',
  ['application/scvp-cv-request'] = 'scq',
  ['application/cdmi-object'] = 'cdmio',
  ['application/x-msdownload'] = 'exe',
  ['application/thraud+xml'] = 'tfi',
  ['application/vnd.kde.kformula'] = 'kfo',
  ['application/x-cdlink'] = 'vcd',
  ['image/x-xbitmap'] = 'xbm',
  ['application/vnd.mobius.mbk'] = 'mbk',
  ['application/jsonml+json'] = 'jsonml',
  ['video/webm'] = 'webm',
  ['application/vnd.pocketlearn'] = 'plf',
  ['application/vnd.fujitsu.oasys2'] = 'oa2',
  ['application/x-msmetafile'] = 'wmz',
  ['application/vnd.intu.qbo'] = 'qbo',
  ['application/x-ms-wmd'] = 'wmd',
  ['application/x-gca-compressed'] = 'gca',
  ['application/mathematica'] = 'mb',
  ['application/mathematica'] = 'nb',
  ['application/x-ms-application'] = 'application',
  ['application/vnd.wolfram.player'] = 'nbp',
  ['application/vnd.fujitsu.oasys'] = 'oas',
  ['application/vnd.oma.dd2+xml'] = 'dd2',
  ['application/vnd.iccprofile'] = 'icm',
  ['application/vnd.ms-works'] = 'wdb',
  ['application/x-director'] = 'dcr',
  ['application/x-mie'] = 'mie',
  ['application/x-glulx'] = 'ulx',
  ['application/x-conference'] = 'nsc',
  ['application/vnd.lotus-screencam'] = 'scm',
  ['application/x-install-instructions'] = 'install',
  ['application/vnd.ipunplugged.rcprofile'] = 'rcprofile',
  ['application/vnd.iccprofile'] = 'icc',
  ['application/vnd.ms-works'] = 'wcm',
  ['application/vnd.cloanto.rp9'] = 'rp9',
  ['application/x-authorware-seg'] = 'aas',
  ['application/vnd.yamaha.smaf-audio'] = 'saf',
  ['application/mathml+xml'] = 'mathml',
  ['application/vnd.tcpdump.pcap'] = 'cap',
  ['application/x-latex'] = 'latex',
  ['application/vnd.americandynamics.acc'] = 'acc',
  ['application/x-font-type1'] = 'afm',
  ['application/vnd.visio'] = 'vst',
  ['application/x-font-ttf'] = 'ttc',
  ['image/x-freehand'] = 'fh5',
  ['application/atom+xml'] = 'atom',
  ['application/vnd.criticaltools.wbs+xml'] = 'wbs',
  ['application/vnd.novadigm.edm'] = 'edm',
  ['application/xv+xml'] = 'xhvml',
  ['application/vnd.crick.clicker.wordbank'] = 'clkw',
  ['application/x-bzip2'] = 'boz',
  ['application/octet-stream'] = 'pkg',
  ['application/vnd.syncml.dm+wbxml'] = 'bdm',
  ['application/marc'] = 'mrc',
  ['application/vnd.ufdl'] = 'ufdl',
  ['application/x-director'] = 'swa',
  ['application/x-director'] = 'w3d',
  ['application/x-authorware-bin'] = 'x32',
  ['application/vnd.acucorp'] = 'atc',
  ['application/onenote'] = 'onetmp',
  ['application/x-debian-package'] = 'udeb',
  ['application/vnd.palm'] = 'pdb',
  ['application/x-debian-package'] = 'deb',
  ['application/dssc+der'] = 'dssc',
  ['application/vnd.oasis.opendocument.database'] = 'odb',
  ['application/vnd.oasis.opendocument.text-master'] = 'odm',
  ['application/pdf'] = 'pdf',
  ['application/vnd.fujixerox.ddd'] = 'ddd',
  ['application/x-cpio'] = 'cpio',
  ['application/x-java-jnlp-file'] = 'jnlp',
  ['application/x-chess-pgn'] = 'pgn',
  ['application/vnd.crick.clicker.palette'] = 'clkp',
  ['application/x-cbr'] = 'cbz',
  ['application/vnd.ibm.modcap'] = 'listafp',
  ['application/font-woff'] = 'woff',
  ['application/vnd.stardivision.draw'] = 'sda',
  ['application/x-cbr'] = 'cbr',
  ['application/vnd.epson.msf'] = 'msf',
  ['application/pkcs7-mime'] = 'p7c',
  ['application/ssdl+xml'] = 'ssdl',
  ['application/x-font-linux-psf'] = 'psf',
  ['application/vnd.fdsn.mseed'] = 'mseed',
  ['application/vnd.lotus-notes'] = 'nsf',
  ['application/vnd.svd'] = 'svd',
  ['application/vnd.oasis.opendocument.chart-template'] = 'otc',
  ['application/vnd.epson.esf'] = 'esf',
  ['application/prs.cww'] = 'cww',
  ['application/x-font-ghostscript'] = 'gsf',
  ['application/sdp'] = 'sdp',
  ['application/vnd.zul'] = 'zirz',
  ['application/vnd.uoml+xml'] = 'uoml',
  ['application/x-blorb'] = 'blb',
  ['application/vnd.hp-hpid'] = 'hpid',
  ['application/x-bittorrent'] = 'torrent',
  ['application/x-authorware-map'] = 'aam',
  ['application/vnd.ms-word.document.macroenabled.12'] = 'docm',
  ['application/vnd.oasis.opendocument.text-web'] = 'oth',
  ['application/x-authorware-bin'] = 'vox',
  ['application/x-director'] = 'cxt',
  ['application/java-vm'] = 'class',
  ['application/vnd.novadigm.ext'] = 'ext',
  ['application/x-7z-compressed'] = '7z',
  ['application/wspolicy+xml'] = 'wspolicy',
  ['application/vnd.oasis.opendocument.graphics-template'] = 'otg',
  ['application/wsdl+xml'] = 'wsdl',
  ['application/vnd.zzazz.deck+xml'] = 'zaz',
  ['application/vnd.sun.xml.calc'] = 'sxc',
  ['application/vnd.zul'] = 'zir',
  ['application/vnd.dynageo'] = 'geo',
  ['application/cdmi-domain'] = 'cdmid',
  ['application/vnd.yamaha.smaf-phrase'] = 'spf',
  ['audio/x-flac'] = 'flac',
  ['application/vnd.yamaha.openscoreformat'] = 'osf',
  ['application/octet-stream'] = 'dump',
  ['text/richtext'] = 'rtx',
  ['application/oebps-package+xml'] = 'opf',
  ['application/vnd.yamaha.hv-dic'] = 'hvd',
  ['application/vnd.mfmp'] = 'mfm',
  ['application/vnd.3gpp.pic-bw-var'] = 'pvb',
  ['application/vnd.xara'] = 'xar',
  ['application/vnd.lotus-freelance'] = 'pre',
  ['application/applixware'] = 'aw',
  ['application/vnd.cinderella'] = 'cdy',
  ['application/x-msmediaview'] = 'mvb',
  ['application/vnd.framemaker'] = 'maker',
  ['application/vnd.webturbo'] = 'wtb',
  ['video/x-ms-asf'] = 'asx',
  ['application/vnd.geometry-explorer'] = 'gre',
  ['application/x-tex-tfm'] = 'tfm',
  ['application/vnd.simtech-mindmapper'] = 'twd',
  ['application/vnd.visio'] = 'vsw',
  ['application/vnd.clonk.c4group'] = 'c4g',
  ['application/x-font-type1'] = 'pfm',
  ['application/dssc+xml'] = 'xdssc',
  ['application/vnd.visio'] = 'vsd',
  ['application/vnd.kde.kivio'] = 'flw',
  ['application/vnd.quark.quarkxpress'] = 'qwd',
  ['text/x-asm'] = 's',
  ['application/vnd.kde.kword'] = 'kwd',
  ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'] = 'xlsx',
  ['application/x-eva'] = 'eva',
  ['application/vnd.ufdl'] = 'ufd',
  ['application/vnd.simtech-mindmapper'] = 'twds',
  ['application/vnd.triscape.mxs'] = 'mxs',
  ['image/cgm'] = 'cgm',
  ['application/octet-stream'] = 'bin',
  ['application/vnd.genomatix.tuxedo'] = 'txd',
  ['application/vnd.syncml.dm+xml'] = 'xdm',
  ['application/vnd.kodak-descriptor'] = 'sse',
  ['application/vnd.syncml+xml'] = 'xsm',
  ['application/vnd.grafeq'] = 'gqs',
  ['application/x-texinfo'] = 'texi',
  ['application/vnd.ms-powerpoint.template.macroenabled.12'] = 'potm',
  ['application/pkcs8'] = 'p8',
  ['application/vnd.insors.igm'] = 'igm',
  ['application/vnd.quark.quarkxpress'] = 'qxl',
  ['application/vnd.ms-powerpoint.addin.macroenabled.12'] = 'ppam',
  ['application/vnd.noblenet-web'] = 'nnw',
  ['application/vnd.commonspace'] = 'csp',
  ['application/vnd.antix.game-component'] = 'atx',
  ['text/sgml'] = 'sgm',
  ['application/vnd.sun.xml.writer.template'] = 'stw',
  ['application/vnd.mobius.txf'] = 'txf',
  ['image/x-portable-graymap'] = 'pgm',
  ['application/vnd.sun.xml.writer'] = 'sxw',
  ['application/vnd.sun.xml.math'] = 'sxm',
  ['application/x-zmachine'] = 'z5',
  ['application/vnd.quark.quarkxpress'] = 'qxd',
  ['application/vnd.sun.xml.draw'] = 'sxd',
  ['application/vnd.audiograph'] = 'aep',
  ['application/vnd.accpac.simply.imp'] = 'imp',
  ['application/vnd.ms-excel'] = 'xlc',
  ['application/mets+xml'] = 'mets',
  ['application/cu-seeme'] = 'cu',
  ['application/vnd.yamaha.hv-script'] = 'hvs',
  ['application/pics-rules'] = 'prf',
  ['application/vnd.stepmania.package'] = 'smzip',
  ['application/x-director'] = 'dxr',
  ['application/vnd.route66.link66+xml'] = 'link66',
  ['application/octet-stream'] = 'lrf',
  ['application/octet-stream'] = 'deploy',
  ['application/vnd.quark.quarkxpress'] = 'qxb',
  ['application/vnd.stardivision.writer'] = 'vor',
  ['application/vnd.hp-hpgl'] = 'hpgl',
  ['application/vnd.data-vision.rdz'] = 'rdz',
  ['image/vnd.ms-modi'] = 'mdi',
  ['application/pgp-encrypted'] = 'pgp',
  ['application/vnd.intergeo'] = 'i2g',
  ['application/vnd.stardivision.math'] = 'smf',
  ['application/vnd.stardivision.impress'] = 'sdd',
  ['application/vnd.stardivision.calc'] = 'sdc',
  ['application/vnd.spotfire.sfs'] = 'sfs',
  ['application/vnd.spotfire.dxp'] = 'dxp',
  ['application/vnd.apple.installer+xml'] = 'mpkg',
  ['text/vnd.dvb.subtitle'] = 'sub',
  ['application/vnd.solent.sdkm+xml'] = 'sdkd',
  ['application/scvp-vp-response'] = 'spp',
  ['audio/mp4'] = 'm4a',
  ['application/vnd.vsf'] = 'vsf',
  ['application/davmount+xml'] = 'davmount',
  ['application/vnd.recordare.musicxml'] = 'mxl',
  ['video/vnd.dece.sd'] = 'uvs',
  ['application/vnd.shana.informed.formdata'] = 'ifm',
  ['application/vnd.epson.ssf'] = 'ssf',
  ['application/vnd.chemdraw+xml'] = 'cdxml',
  ['application/vnd.groove-identity-message'] = 'gim',
  ['application/rls-services+xml'] = 'rs',
  ['application/x-blorb'] = 'blorb',
  ['application/vnd.semd'] = 'semd',
  ['audio/vnd.ms-playready.media.pya'] = 'pya',
  ['application/vnd.framemaker'] = 'fm',
  ['application/octet-stream'] = 'bpk',
  ['image/prs.btif'] = 'btif',
  ['application/vnd.joost.joda-archive'] = 'joda',
  ['application/onenote'] = 'onetoc2',
  ['application/smil+xml'] = 'smil',
  ['application/vnd.intercon.formnet'] = 'xpx',
  ['application/mp21'] = 'mp21',
  ['application/vnd.micrografx.igx'] = 'igx',
  ['video/quicktime'] = 'mov',
  ['application/omdoc+xml'] = 'omdoc',
  ['application/vnd.oasis.opendocument.presentation'] = 'odp',
  ['application/vnd.pmi.widget'] = 'wg',
  ['application/vnd.dece.unspecified'] = 'uvx',
  ['application/xslt+xml'] = 'xslt',
  ['application/vnd.pg.format'] = 'str',
  ['application/java-archive'] = 'jar',
  ['application/mediaservercontrol+xml'] = 'mscml',
  ['application/x-xfig'] = 'fig',
  ['application/vnd.osgeo.mapguide.package'] = 'mgp',
  ['application/vnd.llamagraphics.life-balance.desktop'] = 'lbd',
  ['application/vnd.ms-excel.sheet.binary.macroenabled.12'] = 'xlsb',
  ['application/vnd.osgi.subsystem'] = 'esa',
  ['application/x-font-ttf'] = 'ttf',
  ['application/cdmi-container'] = 'cdmic',
  ['application/rtf'] = 'rtf',
  ['application/octet-stream'] = 'distz',
  ['application/pkix-attr-cert'] = 'ac',
  ['application/x-font-otf'] = 'otf',
  ['application/pgp-signature'] = 'sig',
  ['application/vnd.businessobjects'] = 'rep',
  ['application/vnd.frogans.ltf'] = 'ltf',
  ['application/vnd.dece.ttml+xml'] = 'uvt',
  ['audio/vnd.rip'] = 'rip',
  ['application/vnd.medcalcdata'] = 'mc1',
  ['application/vnd.solent.sdkm+xml'] = 'sdkm',
  ['application/vnd.intercon.formnet'] = 'xpw',
  ['application/x-nzb'] = 'nzb',
  ['application/vnd.fdsn.seed'] = 'seed',
  ['application/vnd.mynfc'] = 'taglet',
  ['application/vnd.ezpix-package'] = 'ez3',
  ['application/vnd.openxmlformats-officedocument.presentationml.slide'] = 'sldx',
  ['text/vnd.in3d.3dml'] = '3dml',
  ['application/vnd.openofficeorg.extension'] = 'oxt',
  ['video/x-ms-wmv'] = 'wmv',
  ['application/mathematica'] = 'ma',
  ['application/vnd.tcpdump.pcap'] = 'pcap',
  ['application/rsd+xml'] = 'rsd',
  ['application/cdmi-capability'] = 'cdmia',
  ['application/vnd.musician'] = 'mus',
  ['application/vnd.3gpp2.tcap'] = 'tcap',
  ['application/vnd.oasis.opendocument.spreadsheet-template'] = 'ots',
  ['application/vnd.oasis.opendocument.spreadsheet'] = 'ods',
  ['application/vnd.ms-excel'] = 'xlw',
  ['application/vnd.curl.pcurl'] = 'pcurl',
  ['application/vnd.accpac.simply.aso'] = 'aso',
  ['application/vnd.oasis.opendocument.image'] = 'odi',
  ['application/zip'] = 'zip',
  ['application/vnd.dece.data'] = 'uvvf',
  ['application/pgp-signature'] = 'asc',
  ['application/vnd.muvee.style'] = 'msty',
  ['application/vnd.quark.quarkxpress'] = 'qwt',
  ['application/x-bzip'] = 'bz',
  ['application/vnd.ahead.space'] = 'ahead',
  ['application/vnd.nokia.radio-presets'] = 'rpss',
  ['application/vnd.aristanetworks.swi'] = 'swi',
  ['application/vnd.fluxtime.clip'] = 'ftc',
  ['application/vnd.proteus.magazine'] = 'mgz',
  ['audio/vnd.nuera.ecelp7470'] = 'ecelp7470',
  ['application/vnd.nitf'] = 'ntf',
  ['audio/x-aiff'] = 'aif',
  ['application/vnd.kde.kword'] = 'kwt',
  ['image/gif'] = 'gif',
  ['application/andrew-inset'] = 'ez',
  ['application/vnd.kde.kpresenter'] = 'kpt',
  ['application/vnd.neurolanguage.nlu'] = 'nlu',
  ['application/oda'] = 'oda',
  ['application/vnd.fujitsu.oasysgp'] = 'fg5',
  ['application/vnd.shana.informed.interchange'] = 'iif',
  ['application/vnd.ms-works'] = 'wps',
  ['application/vnd.dece.data'] = 'uvd',
  ['application/vnd.ezpix-album'] = 'ez2',
  ['application/vnd.mif'] = 'mif',
  ['application/reginfo+xml'] = 'rif',
  ['application/vnd.anser-web-certificate-issue-initiation'] = 'cii',
  ['application/vnd.ds-keypoint'] = 'kpxx',
  ['text/vcard'] = 'vcard',
  ['application/vnd.ms-htmlhelp'] = 'chm',
  ['application/vnd.adobe.xdp+xml'] = 'xdp',
  ['application/vnd.koan'] = 'skm',
  ['application/vnd.ibm.minipay'] = 'mpy',
  ['application/vnd.fuzzysheet'] = 'fzs',
  ['application/vnd.kenameaapp'] = 'htke',
  ['application/vnd.mobius.daf'] = 'daf',
  ['application/vnd.quark.quarkxpress'] = 'qxt',
  ['application/vnd.mfer'] = 'mwf',
  ['application/vnd.airzip.filesecure.azs'] = 'azs',
  ['text/plain'] = 'txt',
  ['application/vnd.sun.xml.impress'] = 'sxi',
  ['application/x-ms-xbap'] = 'xbap',
  ['application/vnd.geonext'] = 'gxt',
  ['application/vnd.lotus-organizer'] = 'org',
  ['application/x-bzip2'] = 'bz2',
  ['application/vnd.contact.cmsg'] = 'cdbcmsg',
  ['application/vnd.koan'] = 'skp',
  ['application/vnd.kinar'] = 'kne',
  ['application/vnd.dece.data'] = 'uvvd',
  ['application/pkcs7-signature'] = 'p7s',
  ['application/exi'] = 'exi',
  ['model/mesh'] = 'msh',
  ['application/vnd.astraea-software.iota'] = 'iota',
  ['application/vnd.crick.clicker.template'] = 'clkt',
  ['application/vnd.hbci'] = 'hbci',
  ['application/vnd.groove-tool-template'] = 'tpl',
  ['application/vnd.ms-excel'] = 'xlm',
  ['application/vnd.fdsn.seed'] = 'dataless',
  ['application/x-xz'] = 'xz',
  ['application/x-shar'] = 'shar',
  ['application/gpx+xml'] = 'gpx',
  ['application/x-csh'] = 'csh',
  ['application/epub+zip'] = 'epub',
  ['application/pkix-pkipath'] = 'pkipath',
  ['application/gml+xml'] = 'gml',
}
-- Returns the common file extension from a content-type
function mimetype.get_mime_extension(content_type)
  return types[content_type]
end

-- Returns the mimetype and subtype
function mimetype.get_content_type(extension)
  for k,v in pairs(types) do
    if v == extension then
      return k
    end
  end
end

-- Returns the mimetype without the subtype
function mimetype.get_content_type_no_sub(extension)
  for k,v in pairs(types) do
    if v == extension then
      -- Before /
      return k:match('([%w-]+)/')
    end
  end
end

return mimetype
