-- создаем таблицы товаров, категорий, а также таблицу совмещения
-- для отображения связи многие-ко-многим

CREATE TABLE Products
(
    ProductID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ProductTitle VARCHAR(50),
    Price DECIMAL(10),
	Discount DECIMAL(4,3) DEFAULT(0.000), CHECK (Discount>=0.000 AND Discount<1.000)
)

CREATE TABLE Categories
(
    CategoryID INT  NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CategoryTitle VARCHAR(50)
)

CREATE TABLE ProductCategories
(
	ProductID INT NOT NULL FOREIGN KEY REFERENCES Products(ProductID),
    CategoryID INT NOT NULL FOREIGN KEY REFERENCES Categories(CategoryID)
	PRIMARY KEY (ProductID, CategoryID)
)

-- заполняем таблицу товаров

INSERT INTO Shopping_DB.dbo.Products
           ([ProductTitle]
           ,[Price]
           ,[Discount])
     VALUES
			('Гречка', 100,0),
			('Молоко', 50,0),
			('Сыр', 150, 0),
			('Овес', 80, 0.5),
			('Хлеб', 70, 0)
           

-- заполняем таблицу категорий

INSERT INTO Shopping_DB.dbo.Categories
           ([CategoryTitle])
     VALUES
           ('Vegan'),('Discounted'),('Special Price')		   
		   
-- заполняем таблицу ProductCategories

INSERT INTO Shopping_DB.dbo.ProductCategories
           ([ProductID],
		   [CategoryID])
     VALUES
           (1, 1),(1,2),(2,3),(4,1)
		   
-- выполняем запрос T-SQL для выбора пар Имя продукта - Имя категории 

SELECT Shopping_DB.dbo.Products.ProductTitle,
	   Shopping_DB.dbo.Categories.CategoryTitle
  FROM Shopping_DB.dbo.Products
  LEFT OUTER JOIN Shopping_DB.dbo.ProductCategories
  ON Shopping_DB.dbo.Products.ProductID = Shopping_DB.dbo.ProductCategories.ProductID
  LEFT OUTER JOIN Shopping_DB.dbo.Categories
  ON Shopping_DB.dbo.Categories.CategoryID = Shopping_DB.dbo.ProductCategories.CategoryID
  
-- результат выполнения возвращает следующий результат
-- Product Title  	|  	Product Category

-- Гречка			|	Vegan
-- Гречка			|	Discounted
-- Молоко			|	Special
-- Сыр				| 	NULL
-- Овес				|   Vegan
-- Хлеб             |   NULL