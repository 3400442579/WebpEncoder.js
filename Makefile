.PHONY: default

default: WebpEncoder.js

WebpEncoder.js WebpEncoder.js.mem: WebpEncoder.cc libwebp
	emcc \
		-O3 -s WASM=1 -s ENVIRONMENT=web \
		-I libwebp \
		-s EXPORTED_FUNCTIONS='["_WebpEncoder_encode", "_WebpEncoder_alloc", "_WebpEncoder_size", "_WebpEncoder_add", "_WebpEncoder_free", "_WebpEncoder_config","_malloc","_free"]' \
		WebpEncoder.cc \
		libwebp/src/dec/*.c \
		libwebp/src/dsp/*.c \
		libwebp/src/demux/*.c \
		libwebp/src/enc/*.c \
		libwebp/src/mux/*.c \
		libwebp/sharpyuv/*.c \
		libwebp/src/utils/*.c \
		--bind \
		--memory-init-file 0 \
		-o build/Webp-Encoder.js

clean:
	rm build/WebpEncoder.js
	rm build/WebpEncoder.js.mem