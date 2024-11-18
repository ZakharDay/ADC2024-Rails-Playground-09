json.extract! @pin, :title, :description, :pin_image

json.set! :comments do
  json.array! @pin.comments, partial: "api/v1/comments/comment", as: :comment
end
