<%@page import="java.util.Random"%>
<%@page import="java_ecommerce.hibernate.model.Product"%>
<%@page import="java.nio.file.StandardCopyOption"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.util.UUID"%>
<%@page import="java_ecommerce.hibernate.model.Category"%>
<%@page import="java_ecommerce.hibernate.dao.ProductDao"%>
<%@page import="java_ecommerce.hibernate.dao.CategoryDao"%>
<%@page import="java_ecommerce.hibernate.model.User"%>
<%@page import="java_ecommerce.hibernate.dao.UserDao"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	// Admin kullancısını ekle
	
	UserDao userDao = new UserDao();
	User admin = new User("admin", "admin", true);
	userDao.save(admin);
	
	// Örnek kategoriler ve ürünleri ekle

	CategoryDao categoryDao = new CategoryDao();
	ProductDao productDao = new ProductDao();
	
	String imgPath = request.getRealPath("img");
	String fullPath = imgPath + File.separator + "example-product-img";
	
	File folder = new File(fullPath);	
	
	for(final File categoryFile : folder.listFiles()){
		// Kategori ekle
		Category category = new Category(categoryFile.getName());
		int categoryId = categoryDao.save(category);
		
		if(categoryId > -1){
			Category dbCategory = categoryDao.fetchById(categoryId);
			
			String imagesPath= fullPath + File.separator + categoryFile.getName();
			File imageFolder = new File(imagesPath);
			
			for(final File imageEntry : imageFolder.listFiles()){
				// Ürün ekle								
				String newImageName = UUID.randomUUID() + ".jpg";
				String newImageFilePath = File.separator + "product"+ File.separator + categoryFile.getName();
				String newImageFolderFullPath = imgPath + newImageFilePath;
				
				File newImgFolder = new File(newImageFolderFullPath);
				if(!newImgFolder.exists()){
					newImgFolder.mkdir();
				}
				
				String newImageFullPath = newImageFolderFullPath + File.separator + newImageName;
				Files.copy(imageEntry.toPath(), (new File(newImageFullPath)).toPath());				
				
				Random rand = new Random();
				
				String imageName = imageEntry.getName().split(".jpg")[0];
				
				Product product = new Product(dbCategory, imageName, rand.nextInt(10000) + 1, rand.nextInt(100) + 1, newImageFilePath + File.separator + newImageName);
				productDao.save(product);				
			}
		}		
	}
	
	response.sendRedirect("index.jsp");
%>