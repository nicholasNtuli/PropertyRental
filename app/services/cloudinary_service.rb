class CloudinaryService
    def upload(file, options = {})
        Cloudinary::Uploader.upload(file, {
            folder: 'properties',
            transformation: [
                { width: 1200, height: 800, crop: 'fill', gravity: 'auto' },
                { quality: 'auto' },
                { fetch_format: 'auto' }
            ],
            eager: [
                { width: 400, height: 300, crop: 'fill' },
                { width: 800, height: 600, crop: 'fill' }
            ]
        }.merge(options))
    end

    def destroy(public_id)
        Cloudinary::Uploader.destroy(public_id)
    end

    def generate_thumbnail(public_id)
        Cloudinary::Util.cloudinary_url(public_id, {
          transformation: [
            { width: 300, height: 200, crop: 'fill' },
            { quality: 'auto' }
          ]  
        })
    end
end