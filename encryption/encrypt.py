from hashlib import sha256
data = b"Example data"

print(data,sha256(data).hexdigest())
# 'b919fbbcae38e2bdaebb6c04ed4098e5c70563d2dc51e085f784c058ff208516'
# 'b919fbbcae38e2bdaebb6c04ed4098e5c70563d2dc51e085f784c058ff208516'
data = b"Example Data 2" # Added one character at the end.
print(sha256(data).hexdigest())
# '9fcaab521baf8e83f07512a7de7a0f567f6eef2688e8b9490694ada0a3ddeec8'