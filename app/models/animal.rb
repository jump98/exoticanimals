class Animal < ApplicationRecord

  belongs_to :user
  has_many :comments, foreign_key: :animal_id, dependent: :destroy

  mount_uploader :image, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  # validates :user_id, presence: true
  validates :image, presence: true
  validates :species, presence: true, length: { maximum: 140 }
  validates :sex, presence: true
  validates :body, presence: true, length: { maximum: 140 }
  validates :color, presence: true, length: { maximum: 140 }
  validate  :image_size


  scope :search, -> (search_params) do
    return if search_params.blank?

    species_like(search_params[:species])
      .sex_is(search_params[:sex])
      .body_like(search_params[:body])
    end
    scope :species_like, -> (species) { where('species LIKE ?', "%#{species}%") if species.present? }
    scope :sex_is, -> (sex) { where(sex: sex) if sex.present? }
    scope :body_like, -> (body) { where('body LIKE ?', "%#{body}%") if body.present? }

  
  private

    # アップロードされた画像のサイズをバリデーションする
    def image_size
      if image.size >= 5.megabytes
        errors.add(:image, :image2, :image3, "ファイルサイズは5MB以下でお願いします。")
      end
    end

end