-- Sử dụng database
USE ShoeStore;

-- Thêm dữ liệu cho bảng Role
INSERT INTO role (roleType, description, createdAt, updatedAt) VALUES
('SUPER_ADMIN', 'Toàn quyền trên hệ thống', NOW(), NOW()),
('ADMIN', 'Quản lý sản phẩm và đơn hàng', NOW(), NOW()),
('CUSTOMER', 'Khách hàng mua hàng', NOW(), NOW());

-- Thêm dữ liệu cho bảng Permission
INSERT INTO permission (name, description, createdAt, updatedAt) VALUES
('MANAGE_USERS', 'Quản lý người dùng', NOW(), NOW()),
('MANAGE_PRODUCTS', 'Quản lý sản phẩm', NOW(), NOW()),
('MANAGE_ORDERS', 'Quản lý đơn hàng', NOW(), NOW()),
('VIEW_REPORTS', 'Xem báo cáo', NOW(), NOW()),
('CREATE_ORDER', 'Tạo đơn hàng', NOW(), NOW()),users
('VIEW_ORDER', 'Xem đơn hàng', NOW(), NOW()),
('WRITE_REVIEW', 'Viết đánh giá', NOW(), NOW()),
('VIEW_PRODUCTS', 'Xem sản phẩm', NOW(), NOW()),
('VIEW_PROMOTION', 'Xem khuyến mãi', NOW(), NOW());

-- Gán quyền cho các vai trò
-- SUPER_ADMIN có tất cả quyền
INSERT INTO role_permissions (roleID, permissionID)
SELECT r.roleID, p.permissionID
FROM role r, permission p
WHERE r.roleType = 'SUPER_ADMIN';

-- ADMIN có quyền quản lý sản phẩm, đơn hàng, báo cáo
INSERT INTO role_permissions (roleID, permissionID)
SELECT r.roleID, p.permissionID
FROM role r, permission p
WHERE r.roleType = 'ADMIN'
AND p.name IN ('MANAGE_PRODUCTS', 'MANAGE_ORDERS', 'VIEW_REPORTS');

-- CUSTOMER có quyền xem sản phẩm, đặt hàng, xem đơn hàng, viết đánh giá
INSERT INTO role_permissions (roleID, permissionID)
SELECT r.roleID, p.permissionID
FROM role r, permission p
WHERE r.roleType = 'CUSTOMER'
AND p.name IN ('CREATE_ORDER', 'VIEW_ORDER', 'WRITE_REVIEW', 'VIEW_PRODUCTS', 'VIEW_PROMOTION');

-- Thêm dữ liệu vào bảng Users
-- Admins
INSERT INTO Users (email, name, password, phoneNumber, status, createdAt, updatedAt)
VALUES
('admin1@example.com', 'Admin User 1', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0334567890', 'ACTIVE', NOW(), NOW()),
('admin2@example.com', 'Admin User 2', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0987654321', 'ACTIVE', NOW(), NOW()),
('admin3@example.com', 'Admin User 3', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0322334455', 'ACTIVE', NOW(), NOW());

-- Customers
INSERT INTO Users (email, name, password, phoneNumber, status, customerGroup, createdAt, updatedAt)
VALUES
('customer1@example.com', 'John Doe', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0333445566', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer2@example.com', 'Jane Smith', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0944556677', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer3@example.com', 'Alice Johnson', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0355667788', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer4@example.com', 'Bob Brown', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0366778899', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer5@example.com', 'Charlie Davis', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0377889900', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer6@example.com', 'Diana Prince', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0388990011', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer7@example.com', 'Ethan Hunt', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0399001122', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer8@example.com', 'Fiona Gallagher', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0300112233', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer9@example.com', 'George Clooney', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0311121314', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer10@example.com', 'Hannah Montana', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0312131415', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer11@example.com', 'Isaac Newton', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0313141516', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer12@example.com', 'Jack Sparrow', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0314151617', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer13@example.com', 'Kara Danvers', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0315161718', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer14@example.com', 'Liam Hemsworth', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0316171819', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer15@example.com', 'Mia Wallace', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0317181920', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer16@example.com', 'Nina Dobrev', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0318192021', 'ACTIVE', 'NEW', NOW(), NOW()),
('customer17@example.com', 'Oscar Isaac', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0319202122', 'ACTIVE', 'EXISTING', NOW(), NOW()),
('customer18@example.com', 'Peter Parker', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0320212223', 'ACTIVE', 'VIP', NOW(), NOW()),
('customer19@example.com', 'Quinn Fabray', '$2a$10$piYOHuFhF7WWTyziAev08.RtlRcnZuruhfrTrgYWO6phJ4l1XvSBm', '0321222324', 'ACTIVE', 'NEW', NOW(), NOW());
-- Gán vai trò cho người dùng
INSERT INTO User_Roles (userID, roleID) VALUES
-- Admins
(1, 1),
(2, 1),
(3, 1),
-- Customers
(4, 3),
(5, 3),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(11, 3),
(12, 3),
(13, 3),
(14, 3),
(15, 3),
(16, 3),
(17, 3),
(18, 3),
(19, 3),
(20, 3),
(21, 3),
(22, 3);

-- Thêm dữ liệu cho bảng Address
INSERT INTO Address (city, district, street, ward, fullName, phone, type, isDefault, userID, createdAt, updatedAt)
VALUES
('Hà Nội', 'Ba Đình', '123 Lê Lợi', 'Phường Cống Vị', 'John Doe', '0123456789', 'Home', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Hà Nội', 'Cầu Giấy', '456 Hoàng Hoa Thám', 'Phường Nghĩa Đô', 'Jane Doe', '0987654321', 'Office', 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Hà Nội', 'Đống Đa', '789 Nguyễn Chí Thanh', 'Phường Láng Hạ', 'Alice Smith', '0912345678', 'Home', 1, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TP. Hồ Chí Minh', 'Quận 1', '12 Hai Bà Trưng', 'Phường Bến Nghé', 'Bob Johnson', '0901122334', 'Office', 0, 4, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('TP. Hồ Chí Minh', 'Quận 2', '34 Nguyễn Huệ', 'Phường Thủ Thiêm', 'Charlie Brown', '0933445566', 'Home', 1, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Đà Nẵng', 'Hải Châu', '56 Trần Phú', 'Phường Hải Châu 1', 'David Lee', '0977889900', 'Home', 0, 6, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Đà Nẵng', 'Thanh Khê', '78 Điện Biên Phủ', 'Phường Thanh Khê Đông', 'Eva Green', '0911223344', 'Office', 1, 7, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Cần Thơ', 'Ninh Kiều', '90 Võ Văn Kiệt', 'Phường An Cư', 'Frank White', '0933778899', 'Home', 0, 8, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Hải Phòng', 'Lê Chân', '11 Nguyễn Trãi', 'Phường An Dương', 'Grace Black', '0976554433', 'Office', 1, 9, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Hải Phòng', 'Ngô Quyền', '22 Hai Bà Trưng', 'Phường Đông Khê', 'Helen Blue', '0944556677', 'Home', 0, 10, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Thừa Thiên Huế', 'Thành phố Huế', '33 Nguyễn Công Trứ', 'Phường Phú Hội', 'Isaac Green', '0911334455', 'Home', 1, 11, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Thừa Thiên Huế', 'Thành phố Huế', '44 Lê Lợi', 'Phường Phú Nhuận', 'Jack Brown', '0933223344', 'Office', 0, 12, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Khánh Hòa', 'Nha Trang', '55 Trần Phú', 'Phường Vạn Thạnh', 'Kathy White', '0988776655', 'Home', 1, 13, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Khánh Hòa', 'Nha Trang', '66 Nguyễn Thiện Thuật', 'Phường Phước Tiến', 'Leo Black', '0912445566', 'Office', 0, 14, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bà Rịa - Vũng Tàu', 'Vũng Tàu', '77 Trần Hưng Đạo', 'Phường 1', 'Mona Green', '0944332211', 'Home', 1, 15, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bà Rịa - Vũng Tàu', 'Vũng Tàu', '88 Nguyễn Trãi', 'Phường Thắng Nhì', 'Nick White', '0933442233', 'Office', 0, 16, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Lâm Đồng', 'Đà Lạt', '99 Lê Hồng Phong', 'Phường 4', 'Olivia Brown', '0911222211', 'Home', 1, 17, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Lâm Đồng', 'Đà Lạt', '10 Nguyễn Văn Cừ', 'Phường 1', 'Paul Black', '0988334455', 'Office', 0, 18, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bình Định', 'Quy Nhơn', '20 Trần Hưng Đạo', 'Phường Lê Lợi', 'Quinn Green', '0944551122', 'Home', 1, 19, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bình Định', 'Quy Nhơn', '30 Võ Thị Sáu', 'Phường Trần Phú', 'Rita White', '0912342211', 'Office', 0, 20, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Thêm dữ liệu cho bảng Brand
INSERT INTO Brand (name, createdAt, updatedAt)
VALUES
('Nike', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Adidas', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Puma', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Reebok', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Under Armour', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Thêm dữ liệu cho bảng Category
INSERT INTO Category (description, name, createdAt, updatedAt)
VALUES
('Shoes for running and sports', 'Running', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for casual wear', 'Lifestyle', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for basketball players', 'Basketball', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for American football players', 'Football', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for gym and training', 'Training', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('High-quality tennis shoes', 'Tennis', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for hiking and trekking', 'Hiking', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Specialized soccer shoes', 'Soccer', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shoes for kids and youth', 'Kids', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Luxury brand shoes', 'Luxury', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Thêm dữ liệu cho bảng Supplier
INSERT INTO Supplier (address, supplierName, createdAt, updatedAt)
VALUES
('123 Main St, New York, NY', 'Global Sports Inc.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('456 Elm St, San Francisco, CA', 'Elite Shoes LLC', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('789 Maple Ave, Chicago, IL', 'Active Wear Co.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('321 Oak St, Seattle, WA', 'Fit and Style Ltd.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('654 Pine St, Boston, MA', 'Performance Gear Corp.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('987 Cedar Rd, Austin, TX', 'Trendsetters Supply', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('159 Spruce St, Miami, FL', 'Urban Outfits Inc.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('753 Birch St, Denver, CO', 'Trail Blazers Ltd.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('951 Aspen Dr, Atlanta, GA', 'Southern Comfort Gear', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('852 Redwood Ave, Portland, OR', 'Pacific Edge Shoes', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Thêm dữ liệu cho bảng Supplier_PhoneNumber
INSERT INTO Supplier_PhoneNumber (supplierID, phoneNumbers)
VALUES
(1, '0911111111'),
(1, '0911222222'),
(2, '0913333333'),
(3, '0914444444'),
(4, '0915555555'),
(5, '0916666666'),
(5, '0911111156'),
(6, '0911222999'),
(6, '0913333458'),
(7, '0914444454'),
(8, '0915554564'),
(9, '0916666846');

-- Thêm dữ liệu cho bảng Product (phải chạy trước Promotion vì Promotion có khóa ngoại đến Product)
INSERT INTO Product (description, price, productName, status, brandID, categoryID, promotionID, supplierID, createdAt, updatedAt)
VALUES
('High-performance running shoes.', 1000000, 'Nike Air Max 270', 'AVAILABLE', 1, 1, NULL, 1, NOW(), NOW()),
('Lightweight basketball sneakers.', 1200000, 'Adidas Harden Vol. 5', 'AVAILABLE', 2, 2, NULL, 2, NOW(), NOW()),
('Stylish hiking boots.', 1500000, 'Timberland Premium', 'AVAILABLE', 3, 3, NULL, 3, NOW(), NOW()),
('Everyday wear sneakers.', 800000, 'Converse Chuck Taylor', 'AVAILABLE', 4, 4, NULL, 4, NOW(), NOW()),
('Elegant leather loafers.', 1000000, 'Clarks Originals', 'AVAILABLE', 5, 5, NULL, 5, NOW(), NOW()),
('Performance tennis shoes.', 1100000, 'Asics Gel-Resolution', 'AVAILABLE', 1, 6, NULL, 6, NOW(), NOW()),
('Classic skate shoes.', 750000, 'Vans Old Skool', 'AVAILABLE', 2, 7, NULL, 7, NOW(), NOW()),
('Premium long-distance runners.', 950000, 'Brooks Ghost 14', 'AVAILABLE', 3, 8, NULL, 8, NOW(), NOW()),
('Breathable sports sandals.', 500000, 'Teva Hurricane XLT2', 'AVAILABLE', 4, 9, NULL, 9, NOW(), NOW()),
('Luxury high heels.', 2000000, 'Jimmy Choo Romy 100', 'AVAILABLE', 5, 10, NULL, 10, NOW(), NOW()),
('Comfort-focused sneakers.', 850000, 'New Balance 574', 'AVAILABLE', 1, 1, NULL, 1, NOW(), NOW()),
('High-performance trainers.', 1200000, 'Under Armour HOVR', 'AVAILABLE', 2, 2, NULL, 2, NOW(), NOW()),
('Waterproof outdoor boots.', 1300000, 'Columbia Bugaboot', 'AVAILABLE', 3, 3, NULL, 3, NOW(), NOW()),
('Athletic running shoes.', 1000000, 'Saucony Endorphin', 'AVAILABLE', 4, 4, NULL, 4, NOW(), NOW()),
('Modern casual loafers.', 900000, 'Sperry Top-Sider', 'AVAILABLE', 5, 5, NULL, 5, NOW(), NOW()),
('Lightweight running shoes.', 750000, 'Reebok Floatride', 'AVAILABLE', 1, 6, NULL, 6, NOW(), NOW()),
('Classic canvas shoes.', 550000, 'Keds Champion', 'AVAILABLE', 2, 7, NULL, 7, NOW(), NOW()),
('Trail running shoes.', 1100000, 'Salomon Speedcross', 'AVAILABLE', 3, 8, NULL, 8, NOW(), NOW()),
('Minimalist sports sandals.', 600000, 'Xero Shoes Z-Trail', 'AVAILABLE', 4, 9, NULL, 9, NOW(), NOW()),
('Luxury dress shoes.', 2500000, 'Gucci Ace Sneakers', 'AVAILABLE', 5, 10, NULL, 10, NOW(), NOW()),
('Casual slip-on sneakers.', 700000, 'Skechers Go Walk', 'AVAILABLE', 1, 1, NULL, 1, NOW(), NOW()),
('Basketball performance shoes.', 1400000, 'Puma Clyde All-Pro', 'AVAILABLE', 2, 2, NULL, 2, NOW(), NOW()),
('Hiking boots with ankle support.', 1600000, 'North Face Vectiv', 'AVAILABLE', 3, 3, NULL, 3, NOW(), NOW()),
('Canvas skate shoes.', 750000, 'DC Shoes Trase', 'AVAILABLE', 4, 4, NULL, 4, NOW(), NOW()),
('Formal leather oxford shoes.', 1300000, 'Allen Edmonds Park Ave', 'AVAILABLE', 5, 5, NULL, 5, NOW(), NOW()),
('Cushioned tennis shoes.', 1150000, 'Fila Axilus 2 Energized', 'AVAILABLE', 1, 6, NULL, 6, NOW(), NOW()),
('Classic low-top sneakers.', 900000, 'Lacoste Carnaby Evo', 'AVAILABLE', 2, 7, NULL, 7, NOW(), NOW()),
('Trail running shoes for grip.', 1250000, 'Hoka Speedgoat', 'AVAILABLE', 3, 8, NULL, 8, NOW(), NOW()),
('Open-toe sports sandals.', 450000, 'Merrell Hydro MOC', 'AVAILABLE', 4, 9, NULL, 9, NOW(), NOW()),
('Elegant party heels.', 2200000, 'Manolo Blahnik BB', 'AVAILABLE', 5, 10, NULL, 10, NOW(), NOW()),
('Everyday cushioned sneakers.', 1000000, 'On Cloud 5', 'AVAILABLE', 1, 1, NULL, 1, NOW(), NOW()),
('Durable basketball sneakers.', 1500000, 'Jordan Retro 1', 'AVAILABLE', 2, 2, NULL, 2, NOW(), NOW()),
('Warm insulated boots.', 1800000, 'Sorel Caribou', 'AVAILABLE', 3, 3, NULL, 3, NOW(), NOW()),
('Stylish slip-ons.', 700000, 'Toms Alpargata', 'AVAILABLE', 4, 4, NULL, 4, NOW(), NOW()),
('Premium leather loafers.', 1900000, 'Tods Gommino', 'AVAILABLE', 5, 5, NULL, 5, NOW(), NOW()),
('High-traction trail runners.', 1300000, 'Arcteryx Norvan', 'AVAILABLE', 1, 6, NULL, 6, NOW(), NOW()),
('Skateboarding classics.', 750000, 'Globe Sabre', 'AVAILABLE', 2, 7, NULL, 7, NOW(), NOW()),
('All-terrain shoes.', 1400000, 'Altra Lone Peak', 'AVAILABLE', 3, 8, NULL, 8, NOW(), NOW()),
('Quick-dry sandals.', 500000, 'Chaco Z/Cloud', 'AVAILABLE', 4, 9, NULL, 9, NOW(), NOW()),
('Luxury red sole heels.', 8000000, 'Christian Louboutin So Kate', 'AVAILABLE', 5, 10, NULL, 10, NOW(), NOW()),
('Lightweight walking shoes.', 600000, 'Skechers Flex Appeal', 'AVAILABLE', 1, 1, NULL, 1, NOW(), NOW()),
('Responsive basketball shoes.', 1300000, 'Nike Zoom Freak', 'AVAILABLE', 2, 2, NULL, 2, NOW(), NOW()),
('Rugged hiking boots.', 1700000, 'Scarpa Zodiac Plus', 'DISCONTINUED', 3, 3, NULL, 3, NOW(), NOW()),
('Casual street sneakers.', 950000, 'Adidas Superstar', 'UNAVAILABLE', 4, 4, NULL, 4, NOW(), NOW()),
('Italian leather dress shoes.', 2500000, 'Santoni Double Monk', 'LIMITED_STOCK', 5, 5, NULL, 5, NOW(), NOW());

-- Thêm dữ liệu cho bảng Promotion (sau khi Product đã có dữ liệu)
INSERT INTO Promotion (
    name, description, type, discountValue, buyQuantity, getQuantity, gift_product_id,
    startDate, endDate, applicableTo, status, usageCount,
    createdAt, updatedAt
) VALUES
    ('Summer Sale 2023', 'Percentage (10%)', 'PERCENTAGE', 10.00, NULL, NULL, NULL,
     '2023-06-01 00:00:00', '2026-08-31 23:59:59', 'ALL', 'ACTIVE', 328,
     NOW(), NOW()),
    ('New Customer Discount', 'Fixed Amount ($20)', 'FIXED', 20000, NULL, NULL, NULL,
     '2023-05-15 00:00:00', '2026-12-31 23:59:59', 'ALL', 'ACTIVE', 145,
     NOW(), NOW()),
    ('Back to School', 'Buy 2 Get 1 Free', 'BUYX', NULL, 2, 1, NULL,
     '2023-08-01 00:00:00', '2026-09-15 23:59:59', 'CATEGORIES', 'UPCOMING', 0,
     NOW(), NOW()),
    ('Holiday Gift', 'Free Gift', 'GIFT', NULL, NULL, NULL, 1, -- productID = 1 đã tồn tại
     '2023-12-01 00:00:00', '2026-12-25 23:59:59', 'ALL', 'UPCOMING', 0,
     NOW(), NOW()),
    ('Black Friday', 'Percentage (30%)', 'PERCENTAGE', 30.00, NULL, NULL, NULL,
     '2022-11-24 00:00:00', '2026-11-28 23:59:59', 'ALL', 'EXPIRED', 512,
     NOW(), NOW()),
    ('Sale 10%', '10% off promotion for products', 'PERCENTAGE', 10.00, NULL, NULL, NULL,
     '2025-02-01 00:00:00', '2025-07-28 23:59:59', 'ALL', 'ACTIVE', 0,
     NOW(), NOW()),
    ('Sale 20%', '20% off promotion for products', 'PERCENTAGE', 20.00, NULL, NULL, NULL,
     '2025-02-01 00:00:00', '2025-07-28 23:59:59', 'ALL', 'ACTIVE', 0,
     NOW(), NOW()),
    ('Sale 50%', '50% off promotion', 'PERCENTAGE', 50.00, NULL, NULL, NULL,
     '2025-02-01 00:00:00', '2025-07-28 23:59:59', 'ALL', 'ACTIVE', 0,
     NOW(), NOW()),
    ('Sale 70%', '70% off promotion', 'PERCENTAGE', 70.00, NULL, NULL, NULL,
     '2025-02-01 00:00:00', '2025-07-28 23:59:59', 'ALL', 'ACTIVE', 0,
     NOW(), NOW()),
    ('Sale 5%', '5% off promotion for products', 'PERCENTAGE', 5.00, NULL, NULL, NULL,
     '2025-02-01 00:00:00', '2025-07-28 23:59:59', 'ALL', 'ACTIVE', 0,
     NOW(), NOW());

-- Thêm dữ liệu cho bảng promotion_customer_groups
-- Promotion 1: Summer Sale 2023 (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (1, 'EXISTING');

-- Promotion 2: New Customer Discount (customerGroup: NEW)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (2, 'NEW');

-- Promotion 3: Back to School (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (3, 'EXISTING');

-- Promotion 4: Holiday Gift (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (4, 'EXISTING');

-- Promotion 5: Black Friday (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (5, 'EXISTING');

-- Promotion 6: Sale 10% (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (6, 'EXISTING');

-- Promotion 7: Sale 20% (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (7, 'EXISTING');

-- Promotion 8: Sale 50% (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (8, 'EXISTING');

-- Promotion 9: Sale 70% (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (9, 'EXISTING');

-- Promotion 10: Sale 5% (customerGroup: EXISTING)
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES (10, 'EXISTING');

DELETE FROM promotion_customer_groups WHERE promotion_id = 1;

-- Thêm tất cả các nhóm khách hàng cho promotion 1
INSERT INTO promotion_customer_groups (promotion_id, customer_group) VALUES
(1, 'NEW'),
(1, 'EXISTING'),
(1, 'VIP');
-- Cập nhật lại Product để gán promotionID (sau khi Promotion đã có dữ liệu)
UPDATE Product SET promotionID = 1 WHERE productID = 1;
UPDATE Product SET promotionID = 2 WHERE productID = 2;
UPDATE Product SET promotionID = 4 WHERE productID = 3;
UPDATE Product SET promotionID = 5 WHERE productID = 4;
UPDATE Product SET promotionID = 1 WHERE productID = 5;
UPDATE Product SET promotionID = 3 WHERE productID = 6;
UPDATE Product SET promotionID = 2 WHERE productID = 7;

INSERT INTO ProductDetail (color, size, stockQuantity, productID, status, image, createdAt, updatedAt)
VALUES
-- productID 1, WHITE, random sizes: 36, 38, 40
('WHITE', 'SIZE_36', 50, 1, 'AVAILABLE', '/1/product1_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 1, 'AVAILABLE', '/1/product1_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 1, 'AVAILABLE', '/1/product1_WHITE', NOW(), NOW()),
-- productID 1, BLACK, random sizes: 37, 39, 41, 43
('BLACK', 'SIZE_37', 50, 1, 'AVAILABLE', '/1/product1_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 1, 'AVAILABLE', '/1/product1_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 1, 'AVAILABLE', '/1/product1_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_43', 50, 1, 'AVAILABLE', '/1/product1_BLACK', NOW(), NOW()),
-- productID 1, GREY, random sizes: 36, 42
('GREY', 'SIZE_36', 50, 1, 'AVAILABLE', '/1/product1_GREY', NOW(), NOW()),
('GREY', 'SIZE_42', 50, 1, 'AVAILABLE', '/1/product1_GREY', NOW(), NOW()),
-- productID 1, PINK, random sizes: 38, 40, 44
('PINK', 'SIZE_38', 50, 1, 'AVAILABLE', '/1/product1_PINK', NOW(), NOW()),
('PINK', 'SIZE_40', 50, 1, 'AVAILABLE', '/1/product1_PINK', NOW(), NOW()),
('PINK', 'SIZE_44', 50, 1, 'AVAILABLE', '/1/product1_PINK', NOW(), NOW()),
-- productID 2, BLACK, random sizes: 36, 39, 41
('BLACK', 'SIZE_36', 50, 2, 'AVAILABLE', '/2/product2_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 2, 'AVAILABLE', '/2/product2_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 2, 'AVAILABLE', '/2/product2_BLACK', NOW(), NOW()),
-- productID 2, PINK, random sizes: 37, 40, 42, 44
('PINK', 'SIZE_37', 50, 2, 'AVAILABLE', '/2/product2_PINK', NOW(), NOW()),
('PINK', 'SIZE_40', 50, 2, 'AVAILABLE', '/2/product2_PINK', NOW(), NOW()),
('PINK', 'SIZE_42', 50, 2, 'AVAILABLE', '/2/product2_PINK', NOW(), NOW()),
('PINK', 'SIZE_44', 50, 2, 'AVAILABLE', '/2/product2_PINK', NOW(), NOW()),
-- productID 2, RED, random sizes: 36, 38
('RED', 'SIZE_36', 50, 2, 'AVAILABLE', '/2/product2_RED', NOW(), NOW()),
('RED', 'SIZE_38', 50, 2, 'AVAILABLE', '/2/product2_RED', NOW(), NOW()),
-- productID 2, WHITE, random sizes: 39, 41, 43
('WHITE', 'SIZE_39', 50, 2, 'AVAILABLE', '/2/product2_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_41', 50, 2, 'AVAILABLE', '/2/product2_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_43', 50, 2, 'AVAILABLE', '/2/product2_WHITE', NOW(), NOW()),
-- productID 3, BLACK, random sizes: 36, 40, 42
('BLACK', 'SIZE_36', 50, 3, 'AVAILABLE', '/3/product3_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 3, 'AVAILABLE', '/3/product3_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_42', 50, 3, 'AVAILABLE', '/3/product3_BLACK', NOW(), NOW()),
-- productID 3, PINK, random sizes: 37, 39, 41, 43
('PINK', 'SIZE_37', 50, 3, 'AVAILABLE', '/3/product3_PINK', NOW(), NOW()),
('PINK', 'SIZE_39', 50, 3, 'AVAILABLE', '/3/product3_PINK', NOW(), NOW()),
('PINK', 'SIZE_41', 50, 3, 'AVAILABLE', '/3/product3_PINK', NOW(), NOW()),
('PINK', 'SIZE_43', 50, 3, 'AVAILABLE', '/3/product3_PINK', NOW(), NOW()),
-- productID 3, RED, random sizes: 36, 38, 44
('RED', 'SIZE_36', 50, 3, 'AVAILABLE', '/3/product3_RED', NOW(), NOW()),
('RED', 'SIZE_38', 50, 3, 'AVAILABLE', '/3/product3_RED', NOW(), NOW()),
('RED', 'SIZE_44', 50, 3, 'AVAILABLE', '/3/product3_RED', NOW(), NOW()),
-- productID 3, BROWN, random sizes: 39, 41
('BROWN', 'SIZE_39', 50, 3, 'AVAILABLE', '/3/product3_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_41', 50, 3, 'AVAILABLE', '/3/product3_BROWN', NOW(), NOW()),
-- productID 4, BLACK, random sizes: 36, 40, 42, 44
('BLACK', 'SIZE_36', 50, 4, 'AVAILABLE', '/4/product4_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 4, 'AVAILABLE', '/4/product4_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_42', 50, 4, 'AVAILABLE', '/4/product4_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_44', 50, 4, 'AVAILABLE', '/4/product4_BLACK', NOW(), NOW()),
-- productID 4, WHITE, random sizes: 37, 39
('WHITE', 'SIZE_37', 50, 4, 'AVAILABLE', '/4/product4_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_39', 50, 4, 'AVAILABLE', '/4/product4_WHITE', NOW(), NOW()),
-- productID 5, BLACK, random sizes: 36, 38, 40
('BLACK', 'SIZE_36', 50, 5, 'AVAILABLE', '/5/product5_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_38', 50, 5, 'AVAILABLE', '/5/product5_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 5, 'AVAILABLE', '/5/product5_BLACK', NOW(), NOW()),
-- productID 5, BROWN, random sizes: 39, 41, 43
('BROWN', 'SIZE_39', 50, 5, 'AVAILABLE', '/5/product5_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_41', 50, 5, 'AVAILABLE', '/5/product5_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_43', 50, 5, 'AVAILABLE', '/5/product5_BROWN', NOW(), NOW()),
-- productID 5, GREY, random sizes: 36, 42, 44
('GREY', 'SIZE_36', 50, 5, 'AVAILABLE', '/5/product5_GREY', NOW(), NOW()),
('GREY', 'SIZE_42', 50, 5, 'AVAILABLE', '/5/product5_GREY', NOW(), NOW()),
('GREY', 'SIZE_44', 50, 5, 'AVAILABLE', '/5/product5_GREY', NOW(), NOW()),
-- productID 5, RED, random sizes: 37, 40
('RED', 'SIZE_37', 50, 5, 'AVAILABLE', '/5/product5_RED', NOW(), NOW()),
('RED', 'SIZE_40', 50, 5, 'AVAILABLE', '/5/product5_RED', NOW(), NOW()),
-- productID 5, YELLOW, random sizes: 38, 41, 43
('YELLOW', 'SIZE_38', 50, 5, 'AVAILABLE', '/5/product5_YELLOW', NOW(), NOW()),
('YELLOW', 'SIZE_41', 50, 5, 'AVAILABLE', '/5/product5_YELLOW', NOW(), NOW()),
('YELLOW', 'SIZE_43', 50, 5, 'AVAILABLE', '/5/product5_YELLOW', NOW(), NOW()),
-- productID 6, BLUE, random sizes: 36, 39, 42
('BLUE', 'SIZE_36', 50, 6, 'AVAILABLE', '/6/product6_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 6, 'AVAILABLE', '/6/product6_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 6, 'AVAILABLE', '/6/product6_BLUE', NOW(), NOW()),
-- productID 6, GREEN, random sizes: 37, 40, 44
('GREEN', 'SIZE_37', 50, 6, 'AVAILABLE', '/6/product6_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_40', 50, 6, 'AVAILABLE', '/6/product6_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_44', 50, 6, 'AVAILABLE', '/6/product6_GREEN', NOW(), NOW()),
-- productID 6, PINK, random sizes: 36, 38, 41
('PINK', 'SIZE_36', 50, 6, 'AVAILABLE', '/6/product6_PINK', NOW(), NOW()),
('PINK', 'SIZE_38', 50, 6, 'AVAILABLE', '/6/product6_PINK', NOW(), NOW()),
('PINK', 'SIZE_41', 50, 6, 'AVAILABLE', '/6/product6_PINK', NOW(), NOW()),
-- productID 6, WHITE, random sizes: 39, 42, 44
('WHITE', 'SIZE_39', 50, 6, 'AVAILABLE', '/6/product6_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 6, 'AVAILABLE', '/6/product6_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 6, 'AVAILABLE', '/6/product6_WHITE', NOW(), NOW()),
-- productID 7, BLACK, random sizes: 36, 40
('BLACK', 'SIZE_36', 50, 7, 'AVAILABLE', '/7/product7_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 7, 'AVAILABLE', '/7/product7_BLACK', NOW(), NOW()),
-- productID 7, RED, random sizes: 37, 39, 41
('RED', 'SIZE_37', 50, 7, 'AVAILABLE', '/7/product7_RED', NOW(), NOW()),
('RED', 'SIZE_39', 50, 7, 'AVAILABLE', '/7/product7_RED', NOW(), NOW()),
('RED', 'SIZE_41', 50, 7, 'AVAILABLE', '/7/product7_RED', NOW(), NOW()),
-- productID 7, WHITE, random sizes: 38, 42, 44
('WHITE', 'SIZE_38', 50, 7, 'AVAILABLE', '/7/product7_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 7, 'AVAILABLE', '/7/product7_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 7, 'AVAILABLE', '/7/product7_WHITE', NOW(), NOW()),
-- productID 8, BLACK, random sizes: 36, 39, 41
('BLACK', 'SIZE_36', 50, 8, 'AVAILABLE', '/8/product8_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 8, 'AVAILABLE', '/8/product8_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 8, 'AVAILABLE', '/8/product8_BLACK', NOW(), NOW()),
-- productID 8, GREEN, random sizes: 37, 40, 42
('GREEN', 'SIZE_37', 50, 8, 'AVAILABLE', '/8/product8_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_40', 50, 8, 'AVAILABLE', '/8/product8_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_42', 50, 8, 'AVAILABLE', '/8/product8_GREEN', NOW(), NOW()),
-- productID 8, PURPLE, random sizes: 36, 38, 44
('PURPLE', 'SIZE_36', 50, 8, 'AVAILABLE', '/8/product8_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_38', 50, 8, 'AVAILABLE', '/8/product8_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_44', 50, 8, 'AVAILABLE', '/8/product8_PURPLE', NOW(), NOW()),
-- productID 9, BLACK, random sizes: 36, 40, 42
('BLACK', 'SIZE_36', 50, 9, 'AVAILABLE', '/9/product9_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 9, 'AVAILABLE', '/9/product9_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_42', 50, 9, 'AVAILABLE', '/9/product9_BLACK', NOW(), NOW()),
-- productID 9, BLUE, random sizes: 37, 39
('BLUE', 'SIZE_37', 50, 9, 'AVAILABLE', '/9/product9_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 9, 'AVAILABLE', '/9/product9_BLUE', NOW(), NOW()),
-- productID 9, GREEN, random sizes: 38, 41, 43
('GREEN', 'SIZE_38', 50, 9, 'AVAILABLE', '/9/product9_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_41', 50, 9, 'AVAILABLE', '/9/product9_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_43', 50, 9, 'AVAILABLE', '/9/product9_GREEN', NOW(), NOW()),
-- productID 9, PINK, random sizes: 36, 42, 44
('PINK', 'SIZE_36', 50, 9, 'AVAILABLE', '/9/product9_PINK', NOW(), NOW()),
('PINK', 'SIZE_42', 50, 9, 'AVAILABLE', '/9/product9_PINK', NOW(), NOW()),
('PINK', 'SIZE_44', 50, 9, 'AVAILABLE', '/9/product9_PINK', NOW(), NOW()),
-- productID 10, BLACK, random sizes: 36, 39, 41
('BLACK', 'SIZE_36', 50, 10, 'AVAILABLE', '/10/product10_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 10, 'AVAILABLE', '/10/product10_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 10, 'AVAILABLE', '/10/product10_BLACK', NOW(), NOW()),
-- productID 10, RED, random sizes: 37, 40, 42
('RED', 'SIZE_37', 50, 10, 'AVAILABLE', '/10/product10_RED', NOW(), NOW()),
('RED', 'SIZE_40', 50, 10, 'AVAILABLE', '/10/product10_RED', NOW(), NOW()),
('RED', 'SIZE_42', 50, 10, 'AVAILABLE', '/10/product10_RED', NOW(), NOW()),
-- productID 10, WHITE, random sizes: 36, 38, 44
('WHITE', 'SIZE_36', 50, 10, 'AVAILABLE', '/10/product10_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 10, 'AVAILABLE', '/10/product10_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 10, 'AVAILABLE', '/10/product10_WHITE', NOW(), NOW()),
-- productID 10, PINK, random sizes: 39, 41, 43
('PINK', 'SIZE_39', 50, 10, 'AVAILABLE', '/10/product10_PINK', NOW(), NOW()),
('PINK', 'SIZE_41', 50, 10, 'AVAILABLE', '/10/product10_PINK', NOW(), NOW()),
('PINK', 'SIZE_43', 50, 10, 'AVAILABLE', '/10/product10_PINK', NOW(), NOW()),
-- productID 11, BLUE, random sizes: 36, 40
('BLUE', 'SIZE_36', 50, 11, 'AVAILABLE', '/11/product11_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_40', 50, 11, 'AVAILABLE', '/11/product11_BLUE', NOW(), NOW()),
-- productID 11, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 11, 'AVAILABLE', '/11/product11_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 11, 'AVAILABLE', '/11/product11_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 11, 'AVAILABLE', '/11/product11_BLACK', NOW(), NOW()),
-- productID 11, GREEN, random sizes: 38, 42, 44
('GREEN', 'SIZE_38', 50, 11, 'AVAILABLE', '/11/product11_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_42', 50, 11, 'AVAILABLE', '/11/product11_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_44', 50, 11, 'AVAILABLE', '/11/product11_GREEN', NOW(), NOW()),
-- productID 11, BROWN, random sizes: 36, 39
('BROWN', 'SIZE_36', 50, 11, 'AVAILABLE', '/11/product11_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_39', 50, 11, 'AVAILABLE', '/11/product11_BROWN', NOW(), NOW()),
-- productID 12, WHITE, random sizes: 36, 40, 42
('WHITE', 'SIZE_36', 50, 12, 'AVAILABLE', '/12/product12_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 12, 'AVAILABLE', '/12/product12_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 12, 'AVAILABLE', '/12/product12_WHITE', NOW(), NOW()),
-- productID 12, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 12, 'AVAILABLE', '/12/product12_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 12, 'AVAILABLE', '/12/product12_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 12, 'AVAILABLE', '/12/product12_BLACK', NOW(), NOW()),
-- productID 12, GREY, random sizes: 36, 38, 44
('GREY', 'SIZE_36', 50, 12, 'AVAILABLE', '/12/product12_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 12, 'AVAILABLE', '/12/product12_GREY', NOW(), NOW()),
('GREY', 'SIZE_44', 50, 12, 'AVAILABLE', '/12/product12_GREY', NOW(), NOW()),
-- productID 12, BROWN, random sizes: 39, 42
('BROWN', 'SIZE_39', 50, 12, 'AVAILABLE', '/12/product12_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_42', 50, 12, 'AVAILABLE', '/12/product12_BROWN', NOW(), NOW()),
-- productID 13, BROWN, random sizes: 36, 40, 42
('BROWN', 'SIZE_36', 50, 13, 'AVAILABLE', '/13/product13_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_40', 50, 13, 'AVAILABLE', '/13/product13_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_42', 50, 13, 'AVAILABLE', '/13/product13_BROWN', NOW(), NOW()),
-- productID 13, ORANGE, random sizes: 37, 39, 41
('ORANGE', 'SIZE_37', 50, 13, 'AVAILABLE', '/13/product13_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_39', 50, 13, 'AVAILABLE', '/13/product13_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_41', 50, 13, 'AVAILABLE', '/13/product13_ORANGE', NOW(), NOW()),
-- productID 14, WHITE, random sizes: 36, 38, 44
('WHITE', 'SIZE_36', 50, 14, 'AVAILABLE', '/14/product14_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 14, 'AVAILABLE', '/14/product14_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 14, 'AVAILABLE', '/14/product14_WHITE', NOW(), NOW()),
-- productID 14, BLACK, random sizes: 39, 41, 43
('BLACK', 'SIZE_39', 50, 14, 'AVAILABLE', '/14/product14_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 14, 'AVAILABLE', '/14/product14_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_43', 50, 14, 'AVAILABLE', '/14/product14_BLACK', NOW(), NOW()),
-- productID 14, BROWN, random sizes: 36, 40
('BROWN', 'SIZE_36', 50, 14, 'AVAILABLE', '/14/product14_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_40', 50, 14, 'AVAILABLE', '/14/product14_BROWN', NOW(), NOW()),
-- productID 15, BROWN, random sizes: 36, 38, 42
('BROWN', 'SIZE_36', 50, 15, 'AVAILABLE', '/15/product15_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_38', 50, 15, 'AVAILABLE', '/15/product15_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_42', 50, 15, 'AVAILABLE', '/15/product15_BROWN', NOW(), NOW()),
-- productID 15, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 15, 'AVAILABLE', '/15/product15_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 15, 'AVAILABLE', '/15/product15_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 15, 'AVAILABLE', '/15/product15_BLACK', NOW(), NOW()),
-- productID 16, WHITE, random sizes: 36, 40, 44
('WHITE', 'SIZE_36', 50, 16, 'AVAILABLE', '/16/product16_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 16, 'AVAILABLE', '/16/product16_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 16, 'AVAILABLE', '/16/product16_WHITE', NOW(), NOW()),
-- productID 16, BLACK, random sizes: 37, 39
('BLACK', 'SIZE_37', 50, 16, 'AVAILABLE', '/16/product16_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 16, 'AVAILABLE', '/16/product16_BLACK', NOW(), NOW()),
-- productID 16, RED, random sizes: 38, 41, 43
('RED', 'SIZE_38', 50, 16, 'AVAILABLE', '/16/product16_RED', NOW(), NOW()),
('RED', 'SIZE_41', 50, 16, 'AVAILABLE', '/16/product16_RED', NOW(), NOW()),
('RED', 'SIZE_43', 50, 16, 'AVAILABLE', '/16/product16_RED', NOW(), NOW()),
-- productID 16, BLUE, random sizes: 36, 42
('BLUE', 'SIZE_36', 50, 16, 'AVAILABLE', '/16/product16_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 16, 'AVAILABLE', '/16/product16_BLUE', NOW(), NOW()),
-- productID 17, WHITE, random sizes: 36, 40, 42
('WHITE', 'SIZE_36', 50, 17, 'AVAILABLE', '/17/product17_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 17, 'AVAILABLE', '/17/product17_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 17, 'AVAILABLE', '/17/product17_WHITE', NOW(), NOW()),
-- productID 17, PURPLE, random sizes: 37, 39, 41
('PURPLE', 'SIZE_37', 50, 17, 'AVAILABLE', '/17/product17_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_39', 50, 17, 'AVAILABLE', '/17/product17_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_41', 50, 17, 'AVAILABLE', '/17/product17_PURPLE', NOW(), NOW()),
-- productID 18, RED, random sizes: 36, 38, 44
('RED', 'SIZE_36', 50, 18, 'AVAILABLE', '/18/product18_RED', NOW(), NOW()),
('RED', 'SIZE_38', 50, 18, 'AVAILABLE', '/18/product18_RED', NOW(), NOW()),
('RED', 'SIZE_44', 50, 18, 'AVAILABLE', '/18/product18_RED', NOW(), NOW()),
-- productID 18, BLACK, random sizes: 39, 41, 43
('BLACK', 'SIZE_39', 50, 18, 'AVAILABLE', '/18/product18_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 18, 'AVAILABLE', '/18/product18_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_43', 50, 18, 'AVAILABLE', '/18/product18_BLACK', NOW(), NOW()),
-- productID 18, GREY, random sizes: 36, 40
('GREY', 'SIZE_36', 50, 18, 'AVAILABLE', '/18/product18_GREY', NOW(), NOW()),
('GREY', 'SIZE_40', 50, 18, 'AVAILABLE', '/18/product18_GREY', NOW(), NOW()),
-- productID 18, BLUE, random sizes: 37, 42, 44
('BLUE', 'SIZE_37', 50, 18, 'AVAILABLE', '/18/product18_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 18, 'AVAILABLE', '/18/product18_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_44', 50, 18, 'AVAILABLE', '/18/product18_BLUE', NOW(), NOW()),
-- productID 19, BLACK, random sizes: 36, 39, 41
('BLACK', 'SIZE_36', 50, 19, 'AVAILABLE', '/19/product19_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 19, 'AVAILABLE', '/19/product19_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 19, 'AVAILABLE', '/19/product19_BLACK', NOW(), NOW()),
-- productID 19, BLUE, random sizes: 37, 40, 42
('BLUE', 'SIZE_37', 50, 19, 'AVAILABLE', '/19/product19_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_40', 50, 19, 'AVAILABLE', '/19/product19_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 19, 'AVAILABLE', '/19/product19_BLUE', NOW(), NOW()),
-- productID 20, WHITE, random sizes: 36, 38, 44
('WHITE', 'SIZE_36', 50, 20, 'AVAILABLE', '/20/product20_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 20, 'AVAILABLE', '/20/product20_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 20, 'AVAILABLE', '/20/product20_WHITE', NOW(), NOW()),
-- productID 20, BLACK, random sizes: 39, 41
('BLACK', 'SIZE_39', 50, 20, 'AVAILABLE', '/20/product20_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 20, 'AVAILABLE', '/20/product20_BLACK', NOW(), NOW()),
-- productID 20, PINK, random sizes: 36, 40, 42
('PINK', 'SIZE_36', 50, 20, 'AVAILABLE', '/20/product20_PINK', NOW(), NOW()),
('PINK', 'SIZE_40', 50, 20, 'AVAILABLE', '/20/product20_PINK', NOW(), NOW()),
('PINK', 'SIZE_42', 50, 20, 'AVAILABLE', '/20/product20_PINK', NOW(), NOW()),
-- productID 20, BLUE, random sizes: 37, 39, 43
('BLUE', 'SIZE_37', 50, 20, 'AVAILABLE', '/20/product20_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 20, 'AVAILABLE', '/20/product20_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_43', 50, 20, 'AVAILABLE', '/20/product20_BLUE', NOW(), NOW()),
-- productID 21, WHITE, random sizes: 36, 40, 44
('WHITE', 'SIZE_36', 50, 21, 'AVAILABLE', '/21/product21_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 21, 'AVAILABLE', '/21/product21_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 21, 'AVAILABLE', '/21/product21_WHITE', NOW(), NOW()),
-- productID 21, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 21, 'AVAILABLE', '/21/product21_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 21, 'AVAILABLE', '/21/product21_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 21, 'AVAILABLE', '/21/product21_BLACK', NOW(), NOW()),
-- productID 21, GREY, random sizes: 36, 38
('GREY', 'SIZE_36', 50, 21, 'AVAILABLE', '/21/product21_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 21, 'AVAILABLE', '/21/product21_GREY', NOW(), NOW()),
-- productID 22, WHITE, random sizes: 36, 40, 42
('WHITE', 'SIZE_36', 50, 22, 'AVAILABLE', '/22/product22_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 22, 'AVAILABLE', '/22/product22_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 22, 'AVAILABLE', '/22/product22_WHITE', NOW(), NOW()),
-- productID 22, PURPLE, random sizes: 37, 39, 43
('PURPLE', 'SIZE_37', 50, 22, 'AVAILABLE', '/22/product22_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_39', 50, 22, 'AVAILABLE', '/22/product22_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_43', 50, 22, 'AVAILABLE', '/22/product22_PURPLE', NOW(), NOW()),
-- productID 22, BLUE, random sizes: 36, 38, 44
('BLUE', 'SIZE_36', 50, 22, 'AVAILABLE', '/22/product22_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_38', 50, 22, 'AVAILABLE', '/22/product22_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_44', 50, 22, 'AVAILABLE', '/22/product22_BLUE', NOW(), NOW()),
-- productID 23, BROWN, random sizes: 36, 40
('BROWN', 'SIZE_36', 50, 23, 'AVAILABLE', '/23/product23_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_40', 50, 23, 'AVAILABLE', '/23/product23_BROWN', NOW(), NOW()),
-- productID 23, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 23, 'AVAILABLE', '/23/product23_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 23, 'AVAILABLE', '/23/product23_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 23, 'AVAILABLE', '/23/product23_BLACK', NOW(), NOW()),
-- productID 23, PINK, random sizes: 36, 38, 44
('PINK', 'SIZE_36', 50, 23, 'AVAILABLE', '/23/product23_PINK', NOW(), NOW()),
('PINK', 'SIZE_38', 50, 23, 'AVAILABLE', '/23/product23_PINK', NOW(), NOW()),
('PINK', 'SIZE_44', 50, 23, 'AVAILABLE', '/23/product23_PINK', NOW(), NOW()),
-- productID 24, WHITE, random sizes: 36, 40, 42
('WHITE', 'SIZE_36', 50, 24, 'AVAILABLE', '/24/product24_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 24, 'AVAILABLE', '/24/product24_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 24, 'AVAILABLE', '/24/product24_WHITE', NOW(), NOW()),
-- productID 24, BLACK, random sizes: 37, 39
('BLACK', 'SIZE_37', 50, 24, 'AVAILABLE', '/24/product24_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 24, 'AVAILABLE', '/24/product24_BLACK', NOW(), NOW()),
-- productID 24, BROWN, random sizes: 36, 38, 44
('BROWN', 'SIZE_36', 50, 24, 'AVAILABLE', '/24/product24_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_38', 50, 24, 'AVAILABLE', '/24/product24_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_44', 50, 24, 'AVAILABLE', '/24/product24_BROWN', NOW(), NOW()),
-- productID 25, BLACK, random sizes: 36, 40, 42
('BLACK', 'SIZE_36', 50, 25, 'AVAILABLE', '/25/product25_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 25, 'AVAILABLE', '/25/product25_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_42', 50, 25, 'AVAILABLE', '/25/product25_BLACK', NOW(), NOW()),
-- productID 26, WHITE, random sizes: 36, 38, 44
('WHITE', 'SIZE_36', 50, 26, 'AVAILABLE', '/26/product26_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 26, 'AVAILABLE', '/26/product26_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 26, 'AVAILABLE', '/26/product26_WHITE', NOW(), NOW()),
-- productID 26, RED, random sizes: 37, 39, 41
('RED', 'SIZE_37', 50, 26, 'AVAILABLE', '/26/product26_RED', NOW(), NOW()),
('RED', 'SIZE_39', 50, 26, 'AVAILABLE', '/26/product26_RED', NOW(), NOW()),
('RED', 'SIZE_41', 50, 26, 'AVAILABLE', '/26/product26_RED', NOW(), NOW()),
-- productID 26, YELLOW, random sizes: 36, 40
('YELLOW', 'SIZE_36', 50, 26, 'AVAILABLE', '/26/product26_YELLOW', NOW(), NOW()),
('YELLOW', 'SIZE_40', 50, 26, 'AVAILABLE', '/26/product26_YELLOW', NOW(), NOW()),
-- productID 27, WHITE, random sizes: 36, 38, 44
('WHITE', 'SIZE_36', 50, 27, 'AVAILABLE', '/27/product27_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 27, 'AVAILABLE', '/27/product27_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_44', 50, 27, 'AVAILABLE', '/27/product27_WHITE', NOW(), NOW()),
-- productID 27, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 27, 'AVAILABLE', '/27/product27_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 27, 'AVAILABLE', '/27/product27_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 27, 'AVAILABLE', '/27/product27_BLACK', NOW(), NOW()),
-- productID 28, GREEN, random sizes: 36, 40, 42
('GREEN', 'SIZE_36', 50, 28, 'AVAILABLE', '/28/product28_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_40', 50, 28, 'AVAILABLE', '/28/product28_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_42', 50, 28, 'AVAILABLE', '/28/product28_GREEN', NOW(), NOW()),
-- productID 28, BLACK, random sizes: 37, 39
('BLACK', 'SIZE_37', 50, 28, 'AVAILABLE', '/28/product28_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 28, 'AVAILABLE', '/28/product28_BLACK', NOW(), NOW()),
-- productID 28, GREY, random sizes: 36, 38, 44
('GREY', 'SIZE_36', 50, 28, 'AVAILABLE', '/28/product28_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 28, 'AVAILABLE', '/28/product28_GREY', NOW(), NOW()),
('GREY', 'SIZE_44', 50, 28, 'AVAILABLE', '/28/product28_GREY', NOW(), NOW()),
-- productID 28, PINK, random sizes: 39, 41, 43
('PINK', 'SIZE_39', 50, 28, 'AVAILABLE', '/28/product28_PINK', NOW(), NOW()),
('PINK', 'SIZE_41', 50, 28, 'AVAILABLE', '/28/product28_PINK', NOW(), NOW()),
('PINK', 'SIZE_43', 50, 28, 'AVAILABLE', '/28/product28_PINK', NOW(), NOW()),
-- productID 29, GREEN, random sizes: 36, 40
('GREEN', 'SIZE_36', 50, 29, 'AVAILABLE', '/29/product29_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_40', 50, 29, 'AVAILABLE', '/29/product29_GREEN', NOW(), NOW()),
-- productID 29, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 29, 'AVAILABLE', '/29/product29_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 29, 'AVAILABLE', '/29/product29_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 29, 'AVAILABLE', '/29/product29_BLACK', NOW(), NOW()),
-- productID 29, GREY, random sizes: 36, 38, 44
('GREY', 'SIZE_36', 50, 29, 'AVAILABLE', '/29/product29_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 29, 'AVAILABLE', '/29/product29_GREY', NOW(), NOW()),
('GREY', 'SIZE_44', 50, 29, 'AVAILABLE', '/29/product29_GREY', NOW(), NOW()),
-- productID 30, BROWN, random sizes: 36, 40, 42
('BROWN', 'SIZE_36', 50, 30, 'AVAILABLE', '/30/product30_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_40', 50, 30, 'AVAILABLE', '/30/product30_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_42', 50, 30, 'AVAILABLE', '/30/product30_BROWN', NOW(), NOW()),
-- productID 30, BLACK, random sizes: 37, 39
('BLACK', 'SIZE_37', 50, 30, 'AVAILABLE', '/30/product30_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 30, 'AVAILABLE', '/30/product30_BLACK', NOW(), NOW()),
-- productID 30, GREY, random sizes: 36, 38, 44
('GREY', 'SIZE_36', 50, 30, 'AVAILABLE', '/30/product30_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 30, 'AVAILABLE', '/30/product30_GREY', NOW(), NOW()),
('GREY', 'SIZE_44', 50, 30, 'AVAILABLE', '/30/product30_GREY', NOW(), NOW()),
-- productID 30, ORANGE, random sizes: 39, 41, 43
('ORANGE', 'SIZE_39', 50, 30, 'AVAILABLE', '/30/product30_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_41', 50, 30, 'AVAILABLE', '/30/product30_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_43', 50, 30, 'AVAILABLE', '/30/product30_ORANGE', NOW(), NOW()),
-- productID 31, WHITE, random sizes: 36, 40
('WHITE', 'SIZE_36', 50, 31, 'AVAILABLE', '/31/product31_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 31, 'AVAILABLE', '/31/product31_WHITE', NOW(), NOW()),
-- productID 31, BROWN, random sizes: 37, 39, 41
('BROWN', 'SIZE_37', 50, 31, 'AVAILABLE', '/31/product31_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_39', 50, 31, 'AVAILABLE', '/31/product31_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_41', 50, 31, 'AVAILABLE', '/31/product31_BROWN', NOW(), NOW()),
-- productID 31, GREY, random sizes: 36, 38, 44
('BLUE', 'SIZE_36', 50, 31, 'AVAILABLE', '/31/product31_GREY', NOW(), NOW()),
('BLUE', 'SIZE_38', 50, 31, 'AVAILABLE', '/31/product31_GREY', NOW(), NOW()),
('BLUE', 'SIZE_44', 50, 31, 'AVAILABLE', '/31/product31_GREY', NOW(), NOW()),
-- productID 31, PURPLE, random sizes: 39, 41
('PURPLE', 'SIZE_39', 50, 31, 'AVAILABLE', '/31/product31_PURPLE', NOW(), NOW()),
('PURPLE', 'SIZE_41', 50, 31, 'AVAILABLE', '/31/product31_PURPLE', NOW(), NOW()),
-- productID 32, WHITE, random sizes: 36, 40, 42
('WHITE', 'SIZE_36', 50, 32, 'AVAILABLE', '/32/product32_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_40', 50, 32, 'AVAILABLE', '/32/product32_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_42', 50, 32, 'AVAILABLE', '/32/product32_WHITE', NOW(), NOW()),
-- productID 32, RED, random sizes: 37, 39
('RED', 'SIZE_37', 50, 32, 'AVAILABLE', '/32/product32_RED', NOW(), NOW()),
('RED', 'SIZE_39', 50, 32, 'AVAILABLE', '/32/product32_RED', NOW(), NOW()),
-- productID 32, GREEN, random sizes: 36, 38, 44
('GREEN', 'SIZE_36', 50, 32, 'AVAILABLE', '/32/product32_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_38', 50, 32, 'AVAILABLE', '/32/product32_GREEN', NOW(), NOW()),
('GREEN', 'SIZE_44', 50, 32, 'AVAILABLE', '/32/product32_GREEN', NOW(), NOW()),
-- productID 32, BLUE, random sizes: 39, 41, 43
('BLUE', 'SIZE_39', 50, 32, 'AVAILABLE', '/32/product32_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 32, 'AVAILABLE', '/32/product32_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_43', 50, 32, 'AVAILABLE', '/32/product32_BLUE', NOW(), NOW()),
-- productID 33, BLACK, random sizes: 36, 40
('BLACK', 'SIZE_36', 50, 33, 'AVAILABLE', '/33/product33_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 33, 'AVAILABLE', '/33/product33_BLACK', NOW(), NOW()),
-- productID 33, BLUE, random sizes: 37, 39, 41
('BLUE', 'SIZE_37', 50, 33, 'AVAILABLE', '/33/product33_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 33, 'AVAILABLE', '/33/product33_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 33, 'AVAILABLE', '/33/product33_BLUE', NOW(), NOW()),
-- productID 34, BROWN, random sizes: 36, 38, 44
('BROWN', 'SIZE_36', 50, 34, 'AVAILABLE', '/34/product34_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_38', 50, 34, 'AVAILABLE', '/34/product34_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_44', 50, 34, 'AVAILABLE', '/34/product34_BROWN', NOW(), NOW()),
-- productID 34, BLACK, random sizes: 39, 41
('BLACK', 'SIZE_39', 50, 34, 'AVAILABLE', '/34/product34_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 34, 'AVAILABLE', '/34/product34_BLACK', NOW(), NOW()),
-- productID 34, BLUE, random sizes: 36, 40, 42
('BLUE', 'SIZE_36', 50, 34, 'AVAILABLE', '/34/product34_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_40', 50, 34, 'AVAILABLE', '/34/product34_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 34, 'AVAILABLE', '/34/product34_BLUE', NOW(), NOW()),
-- productID 35, WHITE, random sizes: 36, 38
('WHITE', 'SIZE_36', 50, 35, 'AVAILABLE', '/35/product35_WHITE', NOW(), NOW()),
('WHITE', 'SIZE_38', 50, 35, 'AVAILABLE', '/35/product35_WHITE', NOW(), NOW()),
-- productID 35, BLUE, random sizes: 37, 39, 41
('BLUE', 'SIZE_37', 50, 35, 'AVAILABLE', '/35/product35_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 35, 'AVAILABLE', '/35/product35_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 35, 'AVAILABLE', '/35/product35_BLUE', NOW(), NOW()),
-- productID 36, BLACK, random sizes: 36, 40, 42
('BLACK', 'SIZE_36', 50, 36, 'AVAILABLE', '/36/product36_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 36, 'AVAILABLE', '/36/product36_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_42', 50, 36, 'AVAILABLE', '/36/product36_BLACK', NOW(), NOW()),
-- productID 36, BLUE, random sizes: 37, 39
('BLUE', 'SIZE_37', 50, 36, 'AVAILABLE', '/36/product36_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 36, 'AVAILABLE', '/36/product36_BLUE', NOW(), NOW()),
-- productID 37, BROWN, random sizes: 36, 38, 44
('BROWN', 'SIZE_36', 50, 37, 'AVAILABLE', '/37/product37_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_38', 50, 37, 'AVAILABLE', '/37/product37_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_44', 50, 37, 'AVAILABLE', '/37/product37_BROWN', NOW(), NOW()),
-- productID 37, BLACK, random sizes: 39, 41, 43
('BLACK', 'SIZE_39', 50, 37, 'AVAILABLE', '/37/product37_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 37, 'AVAILABLE', '/37/product37_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_43', 50, 37, 'AVAILABLE', '/37/product37_BLACK', NOW(), NOW()),
-- productID 38, BLACK, random sizes: 36, 40
('BLACK', 'SIZE_36', 50, 38, 'AVAILABLE', '/38/product38_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_40', 50, 38, 'AVAILABLE', '/38/product38_BLACK', NOW(), NOW()),
-- productID 38, BLUE, random sizes: 37, 39, 41
('BLUE', 'SIZE_37', 50, 38, 'AVAILABLE', '/38/product38_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 38, 'AVAILABLE', '/38/product38_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 38, 'AVAILABLE', '/38/product38_BLUE', NOW(), NOW()),
-- productID 39, BLACK, random sizes: 36, 38, 44
('BLACK', 'SIZE_36', 50, 39, 'AVAILABLE', '/39/product39_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_38', 50, 39, 'AVAILABLE', '/39/product39_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_44', 50, 39, 'AVAILABLE', '/39/product39_BLACK', NOW(), NOW()),
-- productID 39, BLUE, random sizes: 39, 41
('BLUE', 'SIZE_39', 50, 39, 'AVAILABLE', '/39/product39_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 39, 'AVAILABLE', '/39/product39_BLUE', NOW(), NOW()),
-- productID 40, ORANGE, random sizes: 36, 40, 42
('ORANGE', 'SIZE_36', 50, 40, 'AVAILABLE', '/40/product40_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_40', 50, 40, 'AVAILABLE', '/40/product40_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_42', 50, 40, 'AVAILABLE', '/40/product40_ORANGE', NOW(), NOW()),
-- productID 40, BLUE, random sizes: 37, 39
('BLUE', 'SIZE_37', 50, 40, 'AVAILABLE', '/40/product40_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 40, 'AVAILABLE', '/40/product40_BLUE', NOW(), NOW()),
-- productID 41, BROWN, random sizes: 36, 38, 44
('BROWN', 'SIZE_36', 50, 41, 'AVAILABLE', '/41/product41_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_38', 50, 41, 'AVAILABLE', '/41/product41_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_44', 50, 41, 'AVAILABLE', '/41/product41_BROWN', NOW(), NOW()),
-- productID 41, BLACK, random sizes: 39, 41, 43
('BLACK', 'SIZE_39', 50, 41, 'AVAILABLE', '/41/product41_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 41, 'AVAILABLE', '/41/product41_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_43', 50, 41, 'AVAILABLE', '/41/product41_BLACK', NOW(), NOW()),
-- productID 41, GREY, random sizes: 36, 40
('GREY', 'SIZE_36', 50, 41, 'AVAILABLE', '/41/product41_GREY', NOW(), NOW()),
('GREY', 'SIZE_40', 50, 41, 'AVAILABLE', '/41/product41_GREY', NOW(), NOW()),
-- productID 41, BLUE, random sizes: 37, 39, 41
('BLUE', 'SIZE_37', 50, 41, 'AVAILABLE', '/41/product41_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_39', 50, 41, 'AVAILABLE', '/41/product41_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_41', 50, 41, 'AVAILABLE', '/41/product41_BLUE', NOW(), NOW()),
-- productID 42, YELLOW, random sizes: 36, 38, 44
('YELLOW', 'SIZE_36', 50, 42, 'AVAILABLE', '/42/product42_YELLOW', NOW(), NOW()),
('YELLOW', 'SIZE_38', 50, 42, 'AVAILABLE', '/42/product42_YELLOW', NOW(), NOW()),
('YELLOW', 'SIZE_44', 50, 42, 'AVAILABLE', '/42/product42_YELLOW', NOW(), NOW()),
-- productID 42, BLACK, random sizes: 39, 41
('BLACK', 'SIZE_39', 50, 42, 'AVAILABLE', '/42/product42_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 42, 'AVAILABLE', '/42/product42_BLACK', NOW(), NOW()),
-- productID 42, BLUE, random sizes: 36, 40, 42
('BLUE', 'SIZE_36', 50, 42, 'AVAILABLE', '/42/product42_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_40', 50, 42, 'AVAILABLE', '/42/product42_BLUE', NOW(), NOW()),
('BLUE', 'SIZE_42', 50, 42, 'AVAILABLE', '/42/product42_BLUE', NOW(), NOW()),
-- productID 43, GREY, random sizes: 36, 38
('GREY', 'SIZE_36', 50, 43, 'AVAILABLE', '/43/product43_GREY', NOW(), NOW()),
('GREY', 'SIZE_38', 50, 43, 'AVAILABLE', '/43/product43_GREY', NOW(), NOW()),
-- productID 44, RED, random sizes: 36, 40, 42
('RED', 'SIZE_36', 50, 44, 'AVAILABLE', '/44/product44_RED', NOW(), NOW()),
('RED', 'SIZE_40', 50, 44, 'AVAILABLE', '/44/product44_RED', NOW(), NOW()),
('RED', 'SIZE_42', 50, 44, 'AVAILABLE', '/44/product44_RED', NOW(), NOW()),
-- productID 44, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 44, 'AVAILABLE', '/44/product44_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 44, 'AVAILABLE', '/44/product44_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 44, 'AVAILABLE', '/44/product44_BLACK', NOW(), NOW()),
-- productID 44, ORANGE, random sizes: 36, 38, 44
('ORANGE', 'SIZE_36', 50, 44, 'AVAILABLE', '/44/product44_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_38', 50, 44, 'AVAILABLE', '/44/product44_ORANGE', NOW(), NOW()),
('ORANGE', 'SIZE_44', 50, 44, 'AVAILABLE', '/44/product44_ORANGE', NOW(), NOW()),
-- productID 45, BROWN, random sizes: 36, 40
('BROWN', 'SIZE_36', 50, 45, 'AVAILABLE', '/45/product45_BROWN', NOW(), NOW()),
('BROWN', 'SIZE_40', 50, 45, 'AVAILABLE', '/45/product45_BROWN', NOW(), NOW()),
-- productID 45, BLACK, random sizes: 37, 39, 41
('BLACK', 'SIZE_37', 50, 45, 'AVAILABLE', '/45/product45_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_39', 50, 45, 'AVAILABLE', '/45/product45_BLACK', NOW(), NOW()),
('BLACK', 'SIZE_41', 50, 45, 'AVAILABLE', '/45/product45_BLACK', NOW(), NOW());
-- productID 46, RED, random sizes: 36, 38, 44
-- ('RED', 'SIZE_36', 50, 46, 'AVAILABLE', '/46/product46_RED', NOW(), NOW()),
-- ('RED', 'SIZE_38', 50, 46, 'AVAILABLE', '/46/product46_RED', NOW(), NOW()),
-- ('RED', 'SIZE_44', 50, 46, 'AVAILABLE', '/46/product46_RED', NOW(), NOW()),
-- productID 46, BLACK, random sizes: 39, 41
-- ('BLACK', 'SIZE_39', 50, 46, 'AVAILABLE', '/46/product46_BLACK', NOW(), NOW()),
-- ('BLACK', 'SIZE_41', 50, 46, 'AVAILABLE', '/46/product46_BLACK', NOW(), NOW()),
-- productID 46, GREY, random sizes: 36, 40, 42
-- ('GREY', 'SIZE_36', 50, 46, 'AVAILABLE', '/46/product46_GREY', NOW(), NOW()),
-- ('GREY', 'SIZE_40', 50, 46, 'AVAILABLE', '/46/product46_GREY', NOW(), NOW()),
-- ('GREY', 'SIZE_42', 50, 46, 'AVAILABLE', '/46/product46_GREY', NOW(), NOW()),
-- productID 47, BLACK, random sizes: 36, 38
-- ('BLACK', 'SIZE_36', 50, 47, 'AVAILABLE', '/47/product47_BLACK', NOW(), NOW()),
-- ('BLACK', 'SIZE_38', 50, 47, 'AVAILABLE', '/47/product47_BLACK', NOW(), NOW()),
-- productID 47, GREY, random sizes: 37, 39, 41
-- ('GREY', 'SIZE_37', 50, 47, 'AVAILABLE', '/47/product47_GREY', NOW(), NOW()),
-- ('GREY', 'SIZE_39', 50, 47, 'AVAILABLE', '/47/product47_GREY', NOW(), NOW()),
-- ('GREY', 'SIZE_41', 50, 47, 'AVAILABLE', '/47/product47_GREY', NOW(), NOW());


-- Thêm dữ liệu cho bảng Voucher
INSERT INTO Voucher (code, description, discountValue, discountType, minOrderValue, freeShipping, startDate, endDate,customerGroup, status, createdAt, updatedAt)
VALUES
('SPRINGSALE20', 'Get 20% off on your next order.', 20, 'PERCENT', 100000, 0, '2025-02-01T00:00:00', '2025-03-15T23:59:59', 'NEW',1, NOW(), NOW()),
('FREESHIP100K', 'Free shipping for orders above 100,000 VND.', 0, 'FIXED', 100000, 1, '2025-02-01T00:00:00', '2025-03-10T23:59:59','EXISTING', 1, NOW(), NOW()),
('SUMMERSALE15', 'Save 15% on summer collection.', 15, 'PERCENT', 50000, 0, '2025-01-01T00:00:00', '2025-06-30T23:59:59','NEW',1, NOW(), NOW()),
('NEWUSER50K', 'Get 50,000 VND off your first order.', 50000, 'FIXED', 50000, 0, '2025-01-01T00:00:00', '2025-01-31T23:59:59','VIP', 1, NOW(), NOW()),
('WINTERDISCOUNT25', 'Get 25% off on all winter wear.', 25, 'PERCENT', 200000, 0, '2024-12-01T00:00:00', '2025-12-31T23:59:59','VIP', 1, NOW(), NOW());

-- Thêm dữ liệu cho bảng Cart
INSERT INTO Cart (createdAt, updatedAt, userID)
VALUES
(NOW(), NOW(), 1),
(NOW(), NOW(), 2),
(NOW(), NOW(), 3),
(NOW(), NOW(), 4),
(NOW(), NOW(), 5),
(NOW(), NOW(), 6),
(NOW(), NOW(), 7),
(NOW(), NOW(), 8),
(NOW(), NOW(), 9),
(NOW(), NOW(), 10),
(NOW(), NOW(), 11),
(NOW(), NOW(), 12),
(NOW(), NOW(), 13),
(NOW(), NOW(), 14),
(NOW(), NOW(), 15),
(NOW(), NOW(), 16),
(NOW(), NOW(), 17),
(NOW(), NOW(), 18),
(NOW(), NOW(), 19),
(NOW(), NOW(), 20),
(NOW(), NOW(), 21),
(NOW(), NOW(), 22);

-- Thêm dữ liệu cho bảng CartItem
INSERT INTO CartItem (quantity, cartID, productDetailID, createdAt, updatedAt)
VALUES
(2, 1, 1, NOW(), NOW()),
(1, 1, 2, NOW(), NOW()),
(3, 2, 3, NOW(), NOW()),
(1, 2, 4, NOW(), NOW()),
(2, 3, 5, NOW(), NOW()),
(1, 3, 6, NOW(), NOW()),
(2, 4, 7, NOW(), NOW()),
(1, 4, 8, NOW(), NOW()),
(3, 5, 9, NOW(), NOW()),
(2, 5, 10, NOW(), NOW()),
(1, 6, 11, NOW(), NOW()),
(2, 6, 12, NOW(), NOW()),
(1, 7, 13, NOW(), NOW()),
(3, 7, 14, NOW(), NOW()),
(1, 8, 15, NOW(), NOW()),
(2, 8, 16, NOW(), NOW()),
(1, 9, 17, NOW(), NOW()),
(2, 9, 18, NOW(), NOW()),
(3, 10, 19, NOW(), NOW()),
(1, 10, 20, NOW(), NOW());


INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-11 11:39:22', '2025-03-13 11:39:22', 'ORD001', 50000, '2025-03-11', 'VNPAY', 'Số 101, Đường A1, Quận B, TP.HCM', 'DELIVERED', 3600000, 50000, 10, 2);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-02-20 11:39:22', '2025-02-22 11:39:22', 'ORD002', 40000, '2025-02-20', 'CASH', 'Số 102, Đường A2, Quận B, TP.HCM', 'PENDING', 4990000, 50000, 3, 3);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-24 11:39:22', '2025-03-26 11:39:22', 'ORD003', 30000, '2025-03-24', 'CASH', 'Số 103, Đường A3, Quận B, TP.HCM', 'CONFIRMED', 4030000, 0, 9, 3);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-10 11:39:22', '2025-03-12 11:39:22', 'ORD004', 50000, '2025-03-10', 'CASH', 'Số 104, Đường A4, Quận B, TP.HCM', 'CANCELED', 7030000, 20000, 8, 3);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-02-19 11:39:22', '2025-02-21 11:39:22', 'ORD005', 50000, '2025-02-19', 'VNPAY', 'Số 105, Đường A5, Quận B, TP.HCM', 'CANCELED', 1550000, 0, 1, 5);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-02-13 11:39:22', '2025-02-15 11:39:22', 'ORD006', 40000, '2025-02-13', 'CASH', 'Số 106, Đường A6, Quận B, TP.HCM', 'CONFIRMED', 790000, 50000, 7, 5);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-02-18 11:39:22', '2025-02-20 11:39:22', 'ORD007', 30000, '2025-02-18', 'VNPAY', 'Số 107, Đường A7, Quận B, TP.HCM', 'CONFIRMED', 4480000, 50000, 8, 2);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-14 11:39:22', '2025-03-16 11:39:22', 'ORD008', 50000, '2025-03-14', 'VNPAY', 'Số 108, Đường A8, Quận B, TP.HCM', 'CANCELED', 4600000, 50000, 9, NULL);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-02-15 11:39:22', '2025-02-17 11:39:22', 'ORD009', 50000, '2025-02-15', 'CASH', 'Số 109, Đường A9, Quận B, TP.HCM', 'DELIVERED', 1650000, 0, 4, 5);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-04-21 11:39:22', '2025-04-23 11:39:22', 'ORD010', 40000, '2025-04-21', 'VNPAY', 'Số 110, Đường A10, Quận B, TP.HCM', 'DELIVERED', 5320000, 20000, 7, 3);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-04-21 11:39:22', '2025-04-23 11:39:22', 'ORD011', 50000, '2025-04-21', 'VNPAY', 'Số 111, Đường A11, Quận B, TP.HCM', 'CONFIRMED', 5800000, 50000, 3, 5);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-20 11:39:22', '2025-03-22 11:39:22', 'ORD012', 30000, '2025-03-20', 'VNPAY', 'Số 112, Đường A12, Quận B, TP.HCM', 'CONFIRMED', 7430000, 0, 2, 2);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-04-21 11:39:22', '2025-04-23 11:39:22', 'ORD013', 30000, '2025-04-21', 'CASH', 'Số 113, Đường A13, Quận B, TP.HCM', 'PENDING', 5480000, 50000, 6, 2);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-05-03 11:39:22', '2025-05-05 11:39:22', 'ORD014', 50000, '2025-05-03', 'VNPAY', 'Số 114, Đường A14, Quận B, TP.HCM', 'CANCELED', 1030000, 20000, 2, 4);
INSERT INTO Orders (createdAt, updatedAt, code, feeShip, orderDate, paymentMethod, shippingAddress, status, total, voucherDiscount, userID, voucherID) VALUES ('2025-03-08 11:39:22', '2025-03-10 11:39:22', 'ORD015', 30000, '2025-03-08', 'CASH', 'Số 115, Đường A15, Quận B, TP.HCM', 'DELIVERED', 4510000, 20000, 7, 1);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (1, 22, 2, 1000000, '2025-03-11 11:39:22', '2025-03-13 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (1, 12, 2, 800000, '2025-03-11 11:39:22', '2025-03-13 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (2, 5, 2, 1000000, '2025-02-20 11:39:22', '2025-02-22 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (2, 43, 2, 1500000, '2025-02-20 11:39:22', '2025-02-22 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (3, 18, 3, 1000000, '2025-03-24 11:39:22', '2025-03-26 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (3, 16, 1, 1000000, '2025-03-24 11:39:22', '2025-03-26 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (4, 14, 2, 1500000, '2025-03-10 11:39:22', '2025-03-12 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (4, 48, 1, 1000000, '2025-03-10 11:39:22', '2025-03-12 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (4, 9, 2, 1500000, '2025-03-10 11:39:22', '2025-03-12 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (5, 9, 1, 1500000, '2025-02-19 11:39:22', '2025-02-21 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (6, 14, 1, 800000, '2025-02-13 11:39:22', '2025-02-15 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (7, 23, 3, 1500000, '2025-02-18 11:39:22', '2025-02-20 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (8, 50, 2, 800000, '2025-03-14 11:39:22', '2025-03-16 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (8, 21, 2, 1500000, '2025-03-14 11:39:22', '2025-03-16 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (9, 18, 2, 800000, '2025-02-15 11:39:22', '2025-02-17 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (10, 34, 1, 1500000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (10, 9, 2, 1500000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (10, 16, 1, 800000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (11, 11, 3, 800000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (11, 9, 1, 1000000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (11, 48, 3, 800000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (12, 30, 3, 1000000, '2025-03-20 11:39:22', '2025-03-22 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (12, 29, 2, 1000000, '2025-03-20 11:39:22', '2025-03-22 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (12, 21, 3, 800000, '2025-03-20 11:39:22', '2025-03-22 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (13, 22, 1, 1500000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (13, 16, 2, 800000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (13, 34, 3, 800000, '2025-04-21 11:39:22', '2025-04-23 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (14, 49, 1, 1000000, '2025-05-03 11:39:22', '2025-05-05 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderDetail (orderID, productDetailID, quantity, price, createdAt, updatedAt, promotionID, giftProductDetailID, giftedQuantity, promoDiscount) VALUES (15, 39, 3, 1500000, '2025-03-08 11:39:22', '2025-03-10 11:39:22', NULL, NULL, 0, NULL);
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (1, 'PENDING', NULL, NULL, NULL, '2025-03-11 11:39:22', '2025-03-11 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (1, 'CONFIRMED', NULL, NULL, NULL, '2025-03-11 13:39:22', '2025-03-11 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (1, 'SHIPPED', NULL, 'VN000000001', NULL, '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (1, 'DELIVERED', NULL, NULL, '2025-03-13 11:39:22', '2025-03-13 11:39:22', '2025-03-13 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (2, 'PENDING', NULL, NULL, NULL, '2025-02-20 11:39:22', '2025-02-20 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (2, 'CONFIRMED', NULL, NULL, NULL, '2025-02-20 13:39:22', '2025-02-20 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (3, 'PENDING', NULL, NULL, NULL, '2025-03-24 11:39:22', '2025-03-24 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (3, 'CONFIRMED', NULL, NULL, NULL, '2025-03-24 13:39:22', '2025-03-24 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (4, 'PENDING', NULL, NULL, NULL, '2025-03-10 11:39:22', '2025-03-10 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (4, 'CONFIRMED', NULL, NULL, NULL, '2025-03-10 13:39:22', '2025-03-10 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (4, 'CANCELED', 'Khách hàng hủy đơn', NULL, NULL, '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (5, 'PENDING', NULL, NULL, NULL, '2025-02-19 11:39:22', '2025-02-19 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (5, 'CONFIRMED', NULL, NULL, NULL, '2025-02-19 13:39:22', '2025-02-19 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (5, 'CANCELED', 'Khách hàng hủy đơn', NULL, NULL, '2025-02-21 11:39:22', '2025-02-21 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (6, 'PENDING', NULL, NULL, NULL, '2025-02-13 11:39:22', '2025-02-13 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (6, 'CONFIRMED', NULL, NULL, NULL, '2025-02-13 13:39:22', '2025-02-13 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (7, 'PENDING', NULL, NULL, NULL, '2025-02-18 11:39:22', '2025-02-18 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (7, 'CONFIRMED', NULL, NULL, NULL, '2025-02-18 13:39:22', '2025-02-18 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (8, 'PENDING', NULL, NULL, NULL, '2025-03-14 11:39:22', '2025-03-14 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (8, 'CONFIRMED', NULL, NULL, NULL, '2025-03-14 13:39:22', '2025-03-14 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (8, 'CANCELED', 'Khách hàng hủy đơn', NULL, NULL, '2025-03-16 11:39:22', '2025-03-16 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (9, 'PENDING', NULL, NULL, NULL, '2025-02-15 11:39:22', '2025-02-15 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (9, 'CONFIRMED', NULL, NULL, NULL, '2025-02-15 13:39:22', '2025-02-15 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (9, 'SHIPPED', NULL, 'VN000000009', NULL, '2025-02-16 11:39:22', '2025-02-16 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (9, 'DELIVERED', NULL, NULL, '2025-02-17 11:39:22', '2025-02-17 11:39:22', '2025-02-17 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (10, 'PENDING', NULL, NULL, NULL, '2025-04-21 11:39:22', '2025-04-21 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (10, 'CONFIRMED', NULL, NULL, NULL, '2025-04-21 13:39:22', '2025-04-21 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (10, 'SHIPPED', NULL, 'VN000000010', NULL, '2025-04-22 11:39:22', '2025-04-22 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (10, 'DELIVERED', NULL, NULL, '2025-04-23 11:39:22', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (11, 'PENDING', NULL, NULL, NULL, '2025-04-21 11:39:22', '2025-04-21 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (11, 'CONFIRMED', NULL, NULL, NULL, '2025-04-21 13:39:22', '2025-04-21 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (12, 'PENDING', NULL, NULL, NULL, '2025-03-20 11:39:22', '2025-03-20 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (12, 'CONFIRMED', NULL, NULL, NULL, '2025-03-20 13:39:22', '2025-03-20 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (13, 'PENDING', NULL, NULL, NULL, '2025-04-21 11:39:22', '2025-04-21 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (13, 'CONFIRMED', NULL, NULL, NULL, '2025-04-21 13:39:22', '2025-04-21 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (14, 'PENDING', NULL, NULL, NULL, '2025-05-03 11:39:22', '2025-05-03 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (14, 'CONFIRMED', NULL, NULL, NULL, '2025-05-03 13:39:22', '2025-05-03 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (14, 'CANCELED', 'Khách hàng hủy đơn', NULL, NULL, '2025-05-05 11:39:22', '2025-05-05 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (15, 'PENDING', NULL, NULL, NULL, '2025-03-08 11:39:22', '2025-03-08 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (15, 'CONFIRMED', NULL, NULL, NULL, '2025-03-08 13:39:22', '2025-03-08 13:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (15, 'SHIPPED', NULL, 'VN000000015', NULL, '2025-03-09 11:39:22', '2025-03-09 11:39:22');
INSERT INTO OrderStatusHistory (orderID, status, cancelReason, trackingNumber, deliveredAt, createdAt, updatedAt) VALUES (15, 'DELIVERED', NULL, NULL, '2025-03-10 11:39:22', '2025-03-10 11:39:22', '2025-03-10 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4161167, '2025-03-13 11:39:22', 1, '2025-03-13 11:39:22', '2025-03-13 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (2962703, '2025-02-22 11:39:22', 2, '2025-02-22 11:39:22', '2025-02-22 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (1507769, '2025-03-26 11:39:22', 3, '2025-03-26 11:39:22', '2025-03-26 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4677491, '2025-03-12 11:39:22', 4, '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4356633, '2025-02-21 11:39:22', 5, '2025-02-21 11:39:22', '2025-02-21 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4401225, '2025-02-15 11:39:22', 6, '2025-02-15 11:39:22', '2025-02-15 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4862165, '2025-02-20 11:39:22', 7, '2025-02-20 11:39:22', '2025-02-20 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (946101, '2025-03-16 11:39:22', 8, '2025-03-16 11:39:22', '2025-03-16 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (2495762, '2025-02-17 11:39:22', 9, '2025-02-17 11:39:22', '2025-02-17 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (3886634, '2025-04-23 11:39:22', 10, '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4152595, '2025-04-23 11:39:22', 11, '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (4796952, '2025-03-22 11:39:22', 12, '2025-03-22 11:39:22', '2025-03-22 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (2485782, '2025-04-23 11:39:22', 13, '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (2133019, '2025-05-05 11:39:22', 14, '2025-05-05 11:39:22', '2025-05-05 11:39:22');
INSERT INTO Receipt (total, receiptDate, orderID, createdAt, updatedAt) VALUES (3458544, '2025-03-10 11:39:22', 15, '2025-03-10 11:39:22', '2025-03-10 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (1, '2025-03-13 11:39:22', 'SUCCESS', '2025-03-13 11:39:22', '2025-03-13 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (2, '2025-02-22 11:39:22', 'PENDING', '2025-02-22 11:39:22', '2025-02-22 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (3, '2025-03-26 11:39:22', 'PENDING', '2025-03-26 11:39:22', '2025-03-26 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (4, '2025-03-12 11:39:22', 'PENDING', '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (5, '2025-02-21 11:39:22', 'PENDING', '2025-02-21 11:39:22', '2025-02-21 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (6, '2025-02-15 11:39:22', 'PENDING', '2025-02-15 11:39:22', '2025-02-15 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (7, '2025-02-20 11:39:22', 'PENDING', '2025-02-20 11:39:22', '2025-02-20 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (8, '2025-03-16 11:39:22', 'PENDING', '2025-03-16 11:39:22', '2025-03-16 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (9, '2025-02-17 11:39:22', 'SUCCESS', '2025-02-17 11:39:22', '2025-02-17 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (10, '2025-04-23 11:39:22', 'SUCCESS', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (11, '2025-04-23 11:39:22', 'PENDING', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (12, '2025-03-22 11:39:22', 'PENDING', '2025-03-22 11:39:22', '2025-03-22 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (13, '2025-04-23 11:39:22', 'PENDING', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (14, '2025-05-05 11:39:22', 'PENDING', '2025-05-05 11:39:22', '2025-05-05 11:39:22');
INSERT INTO Payment (orderID, paymentDate, status, createdAt, updatedAt) VALUES (15, '2025-03-10 11:39:22', 'SUCCESS', '2025-03-10 11:39:22', '2025-03-10 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (10, 8, 1, 4, 'Sản phẩm tốt.', '2025-03-13 11:39:22', '2025-03-13 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (10, 18, 2, 4, 'Sản phẩm tốt.', '2025-03-13 11:39:22', '2025-03-13 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (3, 16, 3, 3, 'Sản phẩm tốt.', '2025-02-22 11:39:22', '2025-02-22 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (3, 16, 4, 3, 'Đúng mô tả.', '2025-02-22 11:39:22', '2025-02-22 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (9, 16, 5, 4, 'Đóng gói đẹp.', '2025-03-26 11:39:22', '2025-03-26 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (9, 16, 6, 4, 'Giao hàng nhanh.', '2025-03-26 11:39:22', '2025-03-26 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (8, 12, 7, 4, 'Hài lòng.', '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (8, 15, 8, 4, 'Đúng mô tả.', '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (8, 12, 9, 5, 'Hài lòng.', '2025-03-12 11:39:22', '2025-03-12 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (1, 6, 10, 5, 'Giao hàng nhanh.', '2025-02-21 11:39:22', '2025-02-21 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (7, 2, 11, 4, 'Sản phẩm tốt.', '2025-02-15 11:39:22', '2025-02-15 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (8, 7, 12, 5, 'Đúng mô tả.', '2025-02-20 11:39:22', '2025-02-20 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (9, 4, 13, 5, 'Giao hàng nhanh.', '2025-03-16 11:39:22', '2025-03-16 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (9, 18, 14, 4, 'Sản phẩm tốt.', '2025-03-16 11:39:22', '2025-03-16 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (4, 15, 15, 4, 'Đóng gói đẹp.', '2025-02-17 11:39:22', '2025-02-17 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (7, 16, 16, 4, 'Đóng gói đẹp.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (7, 11, 17, 5, 'Hài lòng.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (7, 10, 18, 5, 'Hài lòng.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (3, 14, 19, 4, 'Đóng gói đẹp.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (3, 2, 20, 3, 'Đóng gói đẹp.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (3, 9, 21, 4, 'Sản phẩm tốt.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (2, 10, 22, 3, 'Giao hàng nhanh.', '2025-03-22 11:39:22', '2025-03-22 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (2, 14, 23, 3, 'Sản phẩm tốt.', '2025-03-22 11:39:22', '2025-03-22 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (2, 16, 24, 3, 'Giao hàng nhanh.', '2025-03-22 11:39:22', '2025-03-22 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (6, 16, 25, 3, 'Sản phẩm tốt.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (6, 11, 26, 3, 'Đóng gói đẹp.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (6, 18, 27, 4, 'Hài lòng.', '2025-04-23 11:39:22', '2025-04-23 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (2, 20, 28, 4, 'Giao hàng nhanh.', '2025-05-05 11:39:22', '2025-05-05 11:39:22');
INSERT INTO Review (userID, productID, orderDetailID, rating, comment, createdAt, updatedAt) VALUES (7, 12, 29, 3, 'Giao hàng nhanh.', '2025-03-10 11:39:22', '2025-03-10 11:39:22');