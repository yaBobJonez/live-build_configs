ksflatten -c sample-cinnamon.ks -o flat.ks
# setenforce 0
# rm -rf result/
# livemedia-creator --make-iso --ks flat.ks --no-virt --iso-only --resultdir ./result --project "Sample Cinnamon 41" --volid "Sample" --iso-name Sample-Cinnamon-41-x86_64.iso --releasever 41 --nomacboot
# setenforce 1
livecd-creator --config flat.ks --fslabel SampleCinnamon --title "Sample Cinnamon 41" --releasever=41 --cache cache/
rm flat.ks
