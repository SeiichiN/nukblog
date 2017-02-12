class Gazo < ActiveRecord::Base

	# アップロードファイルの妥当性をfile_invalid?メソッドで検証
	validate :file_invalid?

	# 書き込み専用のdataプロパティ(UploadFileオブジェクト)を定義
	def data=(data)
		self.ctype = data.content_type	# ctypeプロパティにコンテンツタイプをセット
		self.image = data.read					# imageプロパティにファイル本体をセット
	end

	# アップロードファイルの妥当性を検証するfile_invalid?メソッドを定義
	private
	def file_invalid?
		ps = ['image/jpeg', 'image/gif', 'image/png']
		errors.add(:image, 'は画像ファイルではありません。') if !ps.include?(self.ctype)
		errors.add(:image, 'のサイズが1MBを超えています。') if self.image.length > 1.megabyte
	end

end
