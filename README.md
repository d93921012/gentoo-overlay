# gentoo-overlay
 D93921012's personal Gentoo Linux overlay.

## 建立個人的 overlay 的方式
我個人會將自己用的 overlay 放在一個目錄下，例如 /home/ajax/overlays/mybox
然後，在 /etc/portage/make.conf 加入
  PORTDIR_OVERLAY="/home/ajax/overlays/mybox"

## ebuild 建立及測試步驟摘要
* 修改後，執行 ebuild gcin-2.8.5.ebuild digest，重新建立 Manifest
* ebuild gcin-2.8.5.ebuild clean，清除暫存檔
* ebuild gcin-2.8.5.ebuild prepare，執行 src_prepare() 的部分
* ebuild gcin-2.8.5.ebuild configure，執行 src_configure() 的部分
* ebuild gcin-2.8.5.ebuild compile，執行 src_compile() 的部分
* ebuild gcin-2.8.5.ebuild install，執行 src_install() 的部分
* ebuild gcin-2.8.5.ebuild qmerge，移除舊版本，安裝新的版本
