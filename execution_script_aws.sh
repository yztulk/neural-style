rm ~/Documents/outputs/*
touch ~/Documents/outputs/log.txt

cd ~/neural-style
echo "$(date) start first iteration" >> log.txt
th ~/neural-style/neural_style.lua \
-content_image ~/Documents/content/sunset.jpeg \
-style_image ~/Documents/styles/psychedelic_colours.jpg \
-output_image ~/Documents/outputs/sunset_psychedelic.jpg \
-num_iterations 1000 \
-image_size 800 \
-save_iter 100 \
-content_layers relu4_2 \
-style_layers relu1_1,relu2_1,relu3_1,relu4_1,relu5_1 \
-gpu -0

echo "$(date) all interations completed" >> log.txt
cd ~/Documents/outputs/
tar -zcvf results.tar.gz ~/Documents/outputs/
echo "Results from neural-style" | mutt -a "results.tar.gz" -s "neural-style results" -- roybout@gmail.com
echo "$(date) email sent and the system has been shut down" >> log.txt
sudo sudo shutdown
