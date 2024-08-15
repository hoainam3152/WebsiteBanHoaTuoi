CREATE DATABASE FlowerStore

use FlowerStore

GO
CREATE TABLE Logins
(
	UserId int IDENTITY(1,1),
	UserName varchar(20) UNIQUE not null,
	Password varchar(30) not null,
	Roles varchar(6) CHECK (Roles In ('admin','user')) DEFAULT 'user',
	constraint PK_LOGIN PRIMARY KEY (UserId)
)

CREATE TABLE EMPLOYEES(
	EmployeeID NVARCHAR (50),
	EmployeeName NVARCHAR (50) NOT NULL,
	Sex NVARCHAR (10),
	EmployeeAddress NVARCHAR (50),
	EmployeeNumber NVARCHAR (11) NOT NULL,
	DateOfBirth DATETIME,
	UserId int,
	PRIMARY KEY CLUSTERED (EmployeeID ASC),
	CONSTRAINT FK_EMPLOYEES_LOGIN FOREIGN KEY(UserId) REFERENCES Logins(UserId)
);

--DROP TABLE Cards
--DROP TABLE OrdersDetails
--DROP TABLE FlowerDetails
--DROP TABLE Categories
--DROP TABLE Ordererd
--DROP TABLE CUSTOMER
--DROP TABLE EMPLOYEES
--DROP TABLE Logins

CREATE TABLE Categories(
	CategoryID INT IDENTITY(1,1),
	CategoryName NVARCHAR (20) NOT NULL,
	CONSTRAINT PK_Categories PRIMARY KEY(CategoryID ASC)
);

CREATE TABLE FlowerDetails(
	FlowerID INT IDENTITY(1,1),
	FlowerName NVARCHAR (50) NOT NULL,
	Path nvarchar(50) NOT NULL,
	Price FLOAT NOT NULL,
	Describe NVARCHAR (500) NOT NULL,
	Ingredients NVARCHAR (300),
	CategoryID INT,
	PRIMARY KEY CLUSTERED (FlowerID ASC),
	CONSTRAINT FK_FlowerDetails_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON UPDATE CASCADE
);

CREATE TABLE CUSTOMER(
    CustomerID INT IDENTITY(1,1),
    CustomerName NVARCHAR(50) NOT NULL,
    CustomerEmail NVARCHAR(50) NOT NULL,
    CustomerNumber CHAR(10) NULL,
	UserId int,
	PRIMARY KEY CLUSTERED (CustomerID ASC),
	CONSTRAINT FK_CUSTOMER_LOGIN FOREIGN KEY(UserId) REFERENCES Logins(UserId) ON UPDATE CASCADE
);

CREATE TABLE Cards(
    CustomerID INT,
    FlowerID INT,
	Path nvarchar(50) NOT NULL,
	FlowerName NVARCHAR (50) NOT NULL,
    Quantity INT NOT NULL,
    Price FLOAT NOT NULL,
    SumPrice FLOAT NOT NULL,
	CONSTRAINT PK_CARDS PRIMARY KEY (CustomerID, FlowerID),
	CONSTRAINT FK_CARDS_CUSTOMER FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID),
	CONSTRAINT FK_CARDS_FlowerDetails FOREIGN KEY(FlowerID) REFERENCES FlowerDetails(FlowerID)
);

CREATE TABLE Ordererd(
    OrderID INT IDENTITY(1000,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    ReceiverName NVARCHAR (50) NOT NULL,
	ReceiverPhone CHAR(10) NOT NULL,
	ReceiverAddress NVARCHAR(80) NOT NULL,
    TotalPrice FLOAT NOT NULL,
	CONSTRAINT PK_Ordererd PRIMARY KEY (OrderID),
	CONSTRAINT FK_Ordererd_Customer FOREIGN KEY(CustomerID) REFERENCES CUSTOMER(CustomerID)
);

CREATE TABLE OrdersDetails(
	OrderID INT,
	FlowerID INT,
	Quantity INT NOT NULL,
	Price FLOAT NOT NULL,
	SumPrice FLOAT NOT NULL,
	PRIMARY KEY CLUSTERED (OrderID ASC, FlowerID ASC),
	CONSTRAINT FK_OrdersDetails_Ordererd FOREIGN KEY(OrderID) REFERENCES Ordererd(OrderID)
);

INSERT INTO Logins(UserName, Password, Roles)
VALUES 
('0773898552','123456','admin'),
('0771234567','123456','user'),
('0908123456','123456','user')

Select * from Logins

INSERT INTO CUSTOMER(CustomerName, CustomerEmail, CustomerNumber, UserId)
VALUES 
(N'Trần Chí Đạt','chidat2003@gmail.com','0771234567',2),
(N'Nguyễn Thị Phương Loan','loanphuong11@gmail.com','0908123456',3)

Select * from CUSTOMER

INSERT INTO Categories(CategoryName)
VALUES 
(N'Hoa Tình Yêu'),
(N'Hoa Chúc Mừng'),
(N'Hoa Sinh Nhật'),
(N'Hoa Tang Lễ'),
(N'Giáng Sinh'),
(N'Lan Hồ Điệp'),
(N'Hoa Khai Trương')

Select * from Categories

-- Viết dữ liệu cho bảng FlowerDetails
INSERT INTO FlowerDetails(FlowerName, Path, Price, Describe, Ingredients, CategoryID)
VALUES 
(N'Đong Đầy Yêu Thương','dong-day-yeu-thuong.png', 2350000, N'Lẵng hoa chứa đầy tình yêu này được tạo nên từ những bông cúc mẫu đơn tím kết hợp với các loại hoa hồng nhiều màu sắc và cực kỳ lãng mạn. Đây là món quà vô cùng phù hợp nếu như bạn muốn tạo một ấn tượng không thể nào phai trong mắt người yêu. Sẽ không có món quà nào tốt hơn lẵng hoa tình yêu này khi bạn muốn đánh dấu cột mốc mối quan hệ tuyệt đẹp của hai bạn.',N'Hoa cúc mẫu đơn, Hoa hồng tím, Hoa cẩm chướng, Các loại lá phụ khác',1),
(N'Yêu Thương Ngọt Ngào', 'Yeu_Thuong_Ngot_Ngao.png', 1460000, N'Bó hoa với thiết kế đặt biệt từ những cánh đỏ đầy lãng mạn, xen giữa là những đóa hồng trắng tinh khôi, xếp thành hình trái tim nổi bật. Bó hoa tượng trưng cho thông điệp "Em là tình yêu duy nhất và tình cảm của anh dành cho em là sâu sắc nhất, không chút tính toán hay do dự, có chuyện gì xảy ra, dù buồn hay vui anh vẩn ở cạnh em đến cuối con đường". Đừng đợi chờ bạn nhé, hãy để bó hoa thay bạn nói những lời yêu thương ngọt ngào nhất.',N'50 hoa hồng đỏ và trắng, xếp hình trái tim bên trong, Hoa sao tím viền xung quanh', 1),
(N'Trái Tim Thủy Chung', 'Trai_tim_thuy_cung.png', 880000, N'Những bông hoa xinh xắn, ý nghĩa được khéo léo sắp xếp trong chiếc hộp quà trái tim đáng yêu, đem đến cho người nhận cảm giác được yêu thương, xúc động và hạnh phúc. Thích hợp với các dịp Valentine, 8/3, kỉ niệm tình yêu, kỉ niệm ngày cưới, tỏ tình, cầu hôn...',N'Hoa hồng đỏ : 7, Hoa cẩm tú cầu : 1, Hoa thạch thảo trắng : 20, Hoa baby phun xanh : 1, Lá phụ trang trí', 1),
(N'Your Day', 'Your_day.png', 470000, N'Hạnh phúc đôi khi không được tính bằng năm, bằng tháng mà hạnh phúc có thể đong đầy dù trong một khoảnh khắc. Hãy gửi đến người bạn yêu thương nhất những khoảnh khắc chứa đựng đầy yêu thương nhé. Bó hoa gồm tông màu hồng lãng mạn của hồng kem kết hợp với vẻ đẹp đầy đáng yêu của cẩm chướng trắng.',N'Hoa hồng kem: 9, Hoa cẩm chướng trắng: 5, Các loại hoa lá phụ trang trí khác', 1),
(N'Tỏa Sáng', 'toa-sang.png', 750000, N'Được làm từ những bông hướng dương tươi nhất và điểm tô bởi những nhánh cúc calimero trắng, lẵng hoa tỏa sáng rực rỡ và mang đầy sức sống, may mắn như nắng ngày hè. Đây sẽ là món quà vô cùng phù hợp nếu như bạn muốn tạo một ấn tượng đến đối tác, đồng nghiệp, bạn bè, hay những người mà bạn thương yêu quan tâm nhất.',N'Hoa hướng dương : 8 cành, Cúc calimero trắng : 10 cành, Các loại lá phụ :Thạch thảo trắng, cúc tana', 2),
(N'Phú Tài', 'phu-tai.png', 4100000, N'Lẵng hoa Phú tài được tạo nên từ hoa hồng ecudor, cúc mẫu đơn xanh, cát tường,.. và được tô điểm bởi các loại lá phụ trang trí khác. Lẵng hoa thích hợp dành tặng những dịp khai trương, chúc mừng, mừng tân gia....',N'Hoa hồng Ecuador Blue: 10 cành, Hoa hồng Ecuador Celeste: 10 cành, Cúc mẫu đơn xanh: 5 cành, Cát trường trắng phun xanh: 20 cành, Cẩm chướng chùm trắng: 10 cành, Green Wicky: 5 cành, Các loại hoa lá phụ: Lá bạc nhí', 2),
(N'Tươi Sáng', 'tuoi-sang.png', 990000, N'Lẵng hoa khai trương Tươi Sáng mang tông màu sáng đầy vui tươi, ngập tràn ánh nắng và niềm vui hân hoan sẽ giúp bạn gửi đến đối tác, doanh nghiệp những lời chúc chân thành và hoan hỉ nhất. Luôn tỏa sáng và hướng đến tương lai tươi đẹp cũng là ý nghĩa mà lẵng hoa hồng Tươi Sáng này mang đến với hoa hồng, môn xanh và mõm sói',N'Hoa hồng hột gà : 10 cành, Lá hồng môn xanh : 10 cành, Hoa mõm sói : 10 cành, Hoa baby trắng : 100gram, Các loại hoa lá phụ : lá dương sỉ.', 2),
(N'Rạng Rỡ', 'rang-ro.png', 1310000, N'Lẫng hoa Rạng Rỡ được tạo nên từ những bông hoa hồng đỏ, hoa đồng tiền đỏ, hoa đồng tiền hồng nhạt và các loại lá phụ trang trí khác. Lẵng hoa thích hợp dành tặng những dịp chúc mừng, mừng khai trương, tân gia....',N'Hoa hồng đỏ: 20 cành, Hoa hồng kem : 15 cành, Hoa đồng tiền đỏ: 10 cành, Hoa đồng tiền hồng nhạt: 10 cành, Đài hoa hướng dương: 5 cành, Các loại hoa lá phụ: lá quỳnh anh.', 2),
(N'Kệ Hoa Khai Trương Đại Thắng', 'dai-thang.png', 2910000, N'Kệ hoa khai trương đại thắng với thiết kế hiện đại với tông màu vàng tươi sáng tạo nên từ những bông hồng vàng, cúc calimero và các loại hoa phụ nhiều màu sắc. Kệ hoa màu vàng tượng trưng cho sự may mắn, tài lộc là món quà hoàn hảo để gửi đến bạn bè, đối tác nhân dịp khai trương cửa hàng hoặc chi nhánh mới của Công ty.',N'Hoa hồng vàng: 30 cành, Hồng juliet: 30 cành, Hồng kem dâu: 20 cành, Cúc ping pong trắng: 10 cành, Đồng tiền trắng: 10 cành, Đồng tiền hồng: 10 cành, Cúc calimero vàng: 20 cành, Hoa lan hồ điệp vàng: 2 cành, Các loại hoa lá phụ: Lá đuôi chồn, lá dương sỉ, lá bạc', 7),
(N'Kệ Hoa Khai Trương Thịnh Vượng', 'khai-truong-thinh-vuong.png', 3000000, N'Sắc đỏ mạnh mẽ và đầy thu hút như trở nên đáng yêu hơn với sự góp mặt của những nhành hoa lan và bi trắng tinh thuần cùng hoa hồng hột gà dịu hiền. Một chiếc kệ pha trộn gữa nét đẹp tuyệt vời của sự mạnh mẽ, nồng nhiệt và sự thanh thuần, đáng yêu thể hiện triết lý về sự giao hoà, về cuộc đời, về thế giới Trong nhu có cương, trong cương có nhu". Đây sẽ là một món quà có ý nghĩa để chúc mừng cho một khởi đầu mới, cho một sự thành công vang dội và cho những điều tốt đẹp đang và sẽ xảy đến.',N'Cúc Mẫu Đơn Hồng Nhạt : 10 cành, Hoa Ohara Hồng : 30 cành, Hoa Hồng Tím : 40 cành, Cúc Pinkpong trắng : 10 cành, Thuỷ Tiên Hồng : 20 cành, Phi Yến Hồng : 20, CànhLan Hồ Điệp Tím : 2 cành ( 6-8 bông/cành ), Các loại hoa lá phụ: Lá Bạc', 7),
(N'Kệ Hoa Khai Trương Đại Cát', 'khai-truong-dai-cat.png', 1600000, N'Mang tông màu chủ đạo của vàng- tượng trưng cho sự cao quý, thành đạt và sự mạnh mẽ và chiến thắng. Kết hợp giữa sắc vàng của đồng tiền và sắc hồng, tím tình cảm từ lilies và cát tường, kệ hoa khai trương đại cát sẽ thay bạn gửi đi dòng thông điệp: chúc khai trương tấn tới, phát đạt và vững tin bước trên con đường hướng đến thành công đầy rạng ngời và tươi sáng.',N'Hoa hồng pastel 40, Hoa đồng tiền, Lá cau: 14 lá', 7),
(N'Kệ Hoa Khai Trương Đại Lợi 2', 'khai-truong-dai-loi-2.png', 3470000, N'Tài lộc, tiền tài luôn tấn tới- Danh truyền, uy tín tỏa muôn phương" là lời chúc may mắn mà kệ hoa này mang đến. Ngập tràn màu sắc hồng xinh xắn tươi sáng của hồng kem tượng trưng cho niềm hy vọng, niềm tin vào tương lai rộng mở phía trước.',N'Hoa hồng Ohara : 50 cành, Hoa hồng juliet : 30 cành, Cúc ping pong : 10 cành, Đồng tiền hồng : 20 cành, Cúc tana: 20 cành, Mõm sói song hỉ: 20 cành, Cúc ying-yang hồng: 15 cành, Cúc calimero tím: 10 cành, Các loại hoa lá phụ: Lá trầu bà phun bạc, lá bạc', 7),
(N'Đắm Say', 'dam-say.png', 1290000, N'Phải làm gì để nói lời yêu thương với những người thân yêu của bạn? Bó hoa Đắm Say là một món quà đầy ý nghĩa dành tặng người thân yêu với sắc tím chủ đạo từ những đóa hồng tím và lavender khô, viền ngoài bằng hoa baby trắng.',N'Hoa hồng tím: 15 cành, Hoa lavender khô: 2 bó, Hoa baby trắng: 50gram', 3),
(N'Xao Xuyến', 'xao-xuyen.png', 650000, N'Sự rung động xao xuyến luôn là một tình cảm đầy sự diệu kì mà lại rất tinh khiết. Khi bạn có cảm giác xao xuyến khi bên cạnh một ai đó, thế giới xung quanh bạn có thể trở thành một màu hồng đầy tươi sáng. Bó hoa được lấy cảm hứng từ vẻ đẹp của tình cảm thơ ngây đó, được tạo nên từ những cánh hồng với tông màu rượu vang nhẹ nhàng cùng với hoa ly đầy quyến rũ. Xao Xuyến là bó hoa thích hợp nhất để cho bạn ngỏ lời thương với người ấy!',N'Hoa hồng vàng: 14 cành, Hoa baby trắng: 50gram, Các loại hoa lá phụ: Lá bạc nhí', 3),
(N'Xuân Xanh', 'xuan-xanh.png', 3200000, N'Bó hoa Xuân xanh là sự kết hợp của 100 cành hồng kem pastel và phi yến. Cực kỳ sang trọng và tinh tế .',N'Hoa hồng kem: 100 cành , Hoa Phi Yến trắng: 10 cành, Hoa baby trắng: 100gram, Các loại hoa lá phụ: Lá tai lừa xẻ', 3),
(N'White Love (Hoa hồng Ohara)', 'white-love-hong-ohara.png', 1190000, N'White Love là một mẫu hoa được thiết kế lấy cảm hứng thiết kế từ những đóa hồng trắng đầy tinh tế. Hoa hồng trắng thể hiện sự thuần khiết và đức hạnh, sự chân thật và thánh thiện. Nếu bạn muốn cho ai đó thấy rằng tình cảm của bạn là xuất phát từ trái tim chân thành và trong sáng thì hãy lựa chọn hoa hồng trắng để bày tỏ và đây chắc chắn sẽ là sự lựa chọn hoàn hảo.',N'Hoa hồng Ohara trắng: 20 cành, Hoa baby trắng: 30 gram, Các loại hoa lá phụ: Lá bạc', 3),
(N'Mãi Nhớ', 'tang-le-mai-nho.png', 1970000, N'Từng chi tiết đều được chú ý, chăm chút kĩ để giúp cho lời chia buồn của bạn được trao gửi một cách thành kính nhất. Những bông hoa hồ điệp tím sang trọng tô điểm trên nền trắng được tạo nên từ những loại hoa đa dạng, giúp làm nên một bố cục độc đáo, trang trọng.',N'Lan hồ điệp trắng, Cát tường xanh', 4),
(N'Lời Tạm Biệt', 'tang-le-loi-tam-biet.png', 1170000, N'Hoa hồng trắng và Lan trắng thể hiện sự yêu thương, tôn trọng người dành cho người đã khuất. Hoa môn trắng như một lời cảm ơn sâu sắc không thể nói của người dành tặng cho người thân cũng như sự tiếc nuối sâu sắc dành cho người mình tôn trọng đã mãi ra đi. Vòng hoa như một lời chúc bình an dành cho người mãi xa, ở nơi nào đó sẽ yên nghỉ bình an.',N'Hoa Hồng trắng : 30 cành , Cúc calimero : 20 cành , Hoa Lan Denro trắng : 20 cành ', 4),
(N'Tiếc Thương', 'tang-le-tiec-thuong.png', 1370000, N'Thể hiện sự thành kính đến với gia quyến với kệ hoa được tô điểm bởi những cành lan trắng tinh tế. Vòng hoa được bao phủ bởi những hoa lan dendro tươi nhất, kết hợp cùng hoa cúc đại đóa trắng to, tưởng nhớ những kỉ niệm tươi đẹp nhất trong dòng thời gian của người khi còn ở bên gia quyến. Vòng hoa này chính là lời tri ân sâu sắc nhất, tưởng nhớ đến sự hi sinh của người đã khuất.',N'Hoa lan dendro trắng: 40 cành, Hoa cúc trắng: 35 cành, Hoa ly vàng : 5 cành, Các loại hoa lá phụ: Lá cau', 4),
(N'Thanh Thản', 'thanh-than.png', 1810000, N'Ai cũng biết kiếp người là hữu hạn, nhưng lời chia tay luôn quá khó nói và để lại nỗi đau theo năm tháng. Một chút cảm thông, chia sẻ trong thời điểm này sẽ giúp người thân của người đã khuất thêm sức mạnh để vượt qua quãng thời gian khó khăn này. Một kệ hoa tang lễ kết thúc giúp bạn bày tỏ sự cảm thông, chia sẻ với gia đình người đã khuất',N'Hoa lan hồ điệp trắng: 4 cành (6-8 bông/ cành ), Lá môn xanh: 10 cành, Lá Môn Trắng : 5 cành, Gương sen: 5 cành, Hoa sen trắng :10 cành, Hoa hồng trắng: 60 cành', 4),
(N'Tùng Yêu', 'tung-yeu.png', 550000, N'Vào mùa giáng sinh, một cây thông Noel thường mang biểu tượng cho sự sống mạnh mẽ, vượt qua mọi trở ngại, xua đuổi tà ma, mang lại cuộc sống phồn vinh, no ấm. Thậm chí, vì tính chất cây thông dù trong khí hậu khắc nghiệt nhất mà vẫn giữ được dáng vẻ mạnh mẽ, xanh tươi và mang màu xanh vĩnh cửu nên cây thông được xem là biểu tượng sự sống. Vậy nên, hình ảnh cây thông Noel gắn liền với Giáng Sinh, mang niềm vui và sự ấm áp đến cho gia đình.',N'Cành cây sơn tùng, cao 60cm, Trang trí', 5),
(N'Christmas Time', 'giang-sinh-time.png', 650000, N'Nếu bạn đã quen thuộc hình ảnh cây thông noel xanh vào mỗi dịp Giáng Sinh, hãy thử đổi mới bằng cây thông noel tông trắng tinh khiết từ hoa baby để tặng người thân thương của mình.',N'300gr baby, Đồ trang trí', 5),
(N'Warm Christmas', 'warm-christmas.png', 750000, N'Giáng Sinh đang cận kề, còn đợi gì nữa mà không đặt ngay một bó hoa với cành thông thật kết hợp với hoa hồng đỏ để tặng cho người thân yêu của mình',N'Cành thông tươi: 5 cành, Hoa hồng đỏ: 5 cành, Hoa bông gòn khô: 3 cành, Trái thông khô: 3 trái, Các loại hoa lá phụ: Chuỗi ngọc đỏ, lá bạc', 5),
(N'Vòng Giáng Sinh', 'vong-giang-sinh.png', 620000, N'Vòng nguyệt quế là biểu tượng cho một tương lai tươi sáng, một mùa xuân ấm áp giữa cái lạnh, cái giá rét của mùa đông và còn là biểu tượng của cái vĩnh hằng. Vòng tròn của vòng nguyệt quế Noel không có điểm đầu cũng không có kết thúc mang ý nghĩa về một cuộc sống viên mãn, hạnh phúc trọn vẹn. Vật liệu để kết vòng nguyệt quế Noel đều là cây thường xuân và các loại cây xanh đây chính là biểu tượng cho sự sinh tồn, sức sống mãnh liệt sự chiến thắng qua suốt mùa đông',N'Lá sơn tùng, Trái thông khô, Trang trí nhựa màu sắc', 5),
(N'Chậu Lan Hồ Điệp - 045', 'lan-ho-diep-045.png', 1400000, N'Chậu Lan Hồ Điệp - 045 sẽ mang thật nhiều tài lộc, vạn sự như ý đến người nhận. Được thiết kế với loại hoa chủ đạo là lan mang đến vẻ đẹp sang trọng, tinh tế và phù hợp để tặng khai trương, chúc mừng. Chậu Lan Hồ Điệp - 045 được đầu tư một cách nghiêm túc vì chúng tôi luôn hiểu rằng đó là uy tín của khách hàng. Đặc biệt là các doanh nghiệp tin yêu và đặt thiết kế hoa chúc mừng phục vụ các dịp khai trương, khánh thành, tổ chức sự kiện và trong các dịp lễ quan trọng khác.',N'5 cành lan hồ điệp tím, Hoa lá trang trí ', 6),
(N'Chậu Lan Hồ Điệp Sức Khỏe', 'lan-ho-diep-suc-khoe.png', 440000, N'Như những mặt trời nhỏ bé nhưng vô cùng sáng chói, những bông hoa lan hồ điệp vàng vừa nở trên cành sẽ giúp cho không gian của bạn thêm phần rực rỡ, đầy sức sống và cũng không kém phần tao nhã, sang trọng. Một món quà phù hợp cho bất cứ dịp vui nào.',N'1 cành lan hồ điệp vàng, Hoa lá trang trí', 6),
(N'Chậu Lan Hồ Điệp 047 - Phú Quý', 'lan-ho-diep-047.png', 1960000, N'Chậu lan hồ điệp gồm 7 cành vàng và trắng được trang trí thật lạ mắt nhưng vẫn đạt được sự sang trọng, tinh tế và bắt mắt. Càng đặc biệt hơn, khi chậu lan Phú Quý được thiết kế riêng dành tặng dịp Tết với những nhành chuỗi ngọc đỏ, như một lời chúc cho một năm mới nhiều may mắn, tràn đầy ấm áp hạnh phúc và thật nhiều sức khỏe. Đây chắc chắn là một món quà mang nhiều ý nghĩa, không thể tuyệt vời hơn để dành tặng cho những người thân yêu và đối tác.',N'7 cành lan hồ điệp vàng, Hoa lá trang trí', 6),
(N'Chậu Lan Hồ Điệp - 031', 'lan-ho-diep-031.png', 1400000, N'Lan hồ điệp được tôn vinh là nữ hoàng của các loài hoa lan, cũng bởi sở hữu vẻ đẹp sang trọng, thanh tao, quý phái mà vẫn không kém phần kiêu sa, quyến rũ. Mấy ai có thể làm ngơ khi vô tình lướt ngang chậu Lan Hồ Điệp trắng tinh khôi này. Chậu 5 cành Lan Hồ Điệp trắng thường thích hợp để trang trí trong những không gian như nhà hàng, khách sạn cao cấp hoặc 1 góc trưng bày xinh xắn trong ngôi nhà chúng ta.',N'Lan hồ điệp trắng : 5', 6)

Select * from FlowerDetails

-- Viết dữ liệu cho bảng EMPLOYEES
SET DATEFORMAT DMY;
INSERT INTO EMPLOYEES (EmployeeID, EmployeeName, Sex, EmployeeAddress, EmployeeNumber, DateOfBirth, UserId)
VALUES 
('NV001', N'Nguyễn Công Phương', N'Name', N'113 Lê Trọng Tấn', '0773898552', '15/05/1997', 1),
('NV002', N'Đỗ Công Vinh', N'Name', N'15 Tây Thạnh', '0906123645', '20/09/1995',1);

SELECT * FROM EMPLOYEES

-- Viết dữ liệu cho bảng Cards
INSERT INTO Cards(CustomerID, FlowerID, Path, FlowerName, Quantity, Price, SumPrice)
VALUES 
(1, 5, 'toa-sang.png', N'Tỏa Sáng', 1, 750000, 750000),
(1, 4, 'Your_day.png', N'Your Day', 2, 470000, 940000)

SELECT * FROM Cards

-- Viết dữ liệu cho bảng Ordererd
SET DATEFORMAT DMY;
INSERT INTO Ordererd (CustomerID, OrderDate, ReceiverName, ReceiverPhone, ReceiverAddress, TotalPrice)
VALUES 
(1, '27/11/2023', N'Lương Xuân Trường', '0791233128', N'14 Cộng Hoà',7100000),
(2, '29/11/2023', N'Lương Bích Hữu', '0780981239', N'51 Trường Chinh',1240000)

SELECT * FROM Ordererd

-- Viết dữ liệu cho bảng OrdersDetails
INSERT INTO OrdersDetails (OrderID, FlowerID, Quantity, Price, SumPrice)
VALUES 
(1000, 10, 1, 3000000, 3000000),
(1000, 6, 1, 4100000, 4100000),
(1001, 23, 2, 620000, 1240000);

SELECT * FROM OrdersDetails