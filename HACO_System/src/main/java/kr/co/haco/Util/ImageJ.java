package kr.co.haco.Util;

import ij.IJ;
import ij.IJEventListener;
import ij.ImageListener;
import ij.ImagePlus;
import ij.ImageStack;
import ij.io.Opener;
import ij.process.ImageProcessor;
import ij.process.StackProcessor;

public class ImageJ {
	static String resize(String fileAbsolutePath, String fileSaveAsNameSuffix) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			// int width = imp.getWidth();
			// int height = imp.getHeight();

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());

			ImageStack resizedStack = sp.resize(800, 600, true);
			imp.setStack(null, resizedStack);
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);
			filePath.replace(filePath.lastIndexOf("."),
					filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return saveAsFilePath;
		} catch (Exception e) {
			System.out.println("Error while resizing Image.");
			e.printStackTrace();
			return null;
		}
	}

	static String resize(String fileAbsolutePath, String fileSaveAsNameSuffix,
			int width, int height) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);
			ImageStack resizedStack = sp.resize(width, height, true);
			imp.setStack(null, resizedStack);
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);
			filePath.replace(filePath.lastIndexOf("."),
					filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return saveAsFilePath;
		} catch (Exception e) {
			System.out.println("Error while resizing Image.");
			e.printStackTrace();
			return null;
		}
	}

	public void resize(int width) {
		// int resizedHeight = (width * buffer.getHeight()) / buffer.getWidth();
		// return resize(width, resizedHeight);
	}

	public static String cropAndResize(String fileAbsolutePath,
			String fileSaveAsNameSuffix) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			int width = imp.getWidth();
			int height = imp.getHeight();

			int cropWidth = 0;
			int cropHeight = 0;

			if (width > height) {
				cropWidth = height;
				cropHeight = height;
			} else {
				cropWidth = width;
				cropHeight = width;
			}

			int x = -1;
			int y = -1;

			if (width == height) {
				x = 0;
				y = 0;
			} else if (width > height) {
				x = (width - height) / 2;
				y = 0;
			} else if (width < height) {
				x = 0;
				y = (height - width) / 2;
			}

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());

			// ImageStack resizedStack = sp.resize(500, 400, true);
			// imp.setStack(null, resizedStack);
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);
			filePath.replace(filePath.lastIndexOf("."),
					filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return saveAsFilePath;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 크롭 메서드
	public static String crop(String fileAbsolutePath,
			String fileSaveAsNameSuffix, int x, int y, int cropWidth,
			int cropHeight) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);
			filePath.replace(filePath.lastIndexOf("."),
					filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return saveAsFilePath;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 크롭 메서드
	public static String crop(String fileAbsolutePath, int x, int y,
			int cropWidth, int cropHeight) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());
			IJ.save(imp, fileAbsolutePath);
			return fileAbsolutePath;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// 크롭&리사이즈
	public static String cropAndResize(String fileAbsolutePath, int x, int y,
			int cropWidth, int cropHeight, int resizeWidth, int resizeHeight) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());

			ImageStack resizedStack = sp
					.resize(resizeWidth, resizeHeight, true);
			imp.setStack(null, resizedStack);
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);

			// filePath.replace(filePath.lastIndexOf("."),
			// filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return "cropAndResize_success";
		} catch (Exception e) {
			System.out.println(e.getMessage());
			// e.printStackTrace();
			return e.getMessage();
		}
	}

	// 짧은 길이 기준 크롭&리사이즈
	public static String thumbnailcropAndResize(String fileAbsolutePath,
			String saveAsFilePath) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			int width = imp.getWidth();
			int height = imp.getHeight();

			int cropWidth = 0;
			int cropHeight = 0;

			if (width > height) {
				cropWidth = (width / 4) * 3;
				cropHeight = height;
			} else {
				cropWidth = width;
				cropHeight = (width / 4) * 3;
			}

			int x = -1;
			int y = -1;

			if (width == height) {
				x = 0;
				y = 0;
			} else if (width > height) {
				x = (width - ((width / 4) * 3)) / 2;
				y = 0;
			} else if (width < height) {
				x = 0;
				y = (height - ((width / 4) * 3)) / 2;
			}

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());

			ImageStack resizedStack = sp.resize(200, 150, true);
			imp.setStack(null, resizedStack);
			/*
			 * StringBuffer filePath = new StringBuffer(saveAsFilePath);
			 * //filePath.replace(filePath.lastIndexOf("."),
			 * filePath.lastIndexOf("."), fileSaveAsNameSuffix);
			 * if((filePath.substring
			 * (filePath.lastIndexOf(".")+1)).equals("JPG")){
			 * filePath.replace(filePath.lastIndexOf("."), filePath.length(),
			 * "jpg"); } saveAsFilePath = filePath.toString();
			 */
			IJ.save(imp, saveAsFilePath);
			
			return "thumbmailcreate_success";
		} catch (Exception e) {
			// e.printStackTrace();
			return e.getMessage();
		}
	}

	public static String photoCropAndResize(String fileAbsolutePath,
			int resizeWidth, int resizeHeight) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			
					
			
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			int width = imp.getWidth();
			int height = imp.getHeight();

			float ratio = (float) resizeWidth / resizeHeight;
			float targetRatio = (float) width / height;

			System.out.println("ratio - " + ratio);
			System.out.println("targetRatio - " + targetRatio);

			if (width != resizeWidth && height != resizeHeight) {
				System.out.println("procresdrse");

				if (ratio < 1) {
					int cropWidth = resizeWidth;
					int cropHeight = resizeHeight;

					if (targetRatio == 1) {
						cropWidth = (int) (width * ratio);
						cropHeight = height;
					} else if (targetRatio > 1) {
						cropWidth = (int) (height * ratio);
						cropHeight = height;
					} else if (targetRatio < 1) {
						cropWidth = width;
						cropHeight = (int) (height * ratio);
					}
					System.out.println(cropWidth);
					System.out.println(cropHeight);

					int x = -1;
					int y = -1;

					if (targetRatio == 1) {
						x = (width - (int) (width * ratio)) / 2;
						y = 0;
					} else if (targetRatio > 1) {
						x = (width - (int) (height * ratio)) / 2;
						y = 0;
					} else if (targetRatio < 1) {
						x = 0;
						y = (height - (int) (height * ratio)) / 2;
					}

					ImageStack croppedStack = sp.crop(x, y, cropWidth,
							cropHeight);
					imp.setStack(croppedStack);

				}

				 sp = new StackProcessor(imp.getStack(), imp.getProcessor());
				 ImageStack resizedStack = sp.resize(resizeWidth,
				 resizeHeight, true);
				 imp.setStack(resizedStack);
				 
				imp.close();
				IJ.save(imp, fileAbsolutePath);
				
				return fileAbsolutePath;
			}
			return "noconvert";
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}

	public static String profilecropAndResize(String fileAbsolutePath) {
		try {
			Opener opener = new Opener();
			ImagePlus imp = opener.openImage(fileAbsolutePath);
			ImageProcessor ip = imp.getProcessor();
			StackProcessor sp = new StackProcessor(imp.getStack(), ip);

			int width = imp.getWidth();
			int height = imp.getHeight();

			int cropWidth = 0;
			int cropHeight = 0;

			if (width > height) {
				cropWidth = height;
				cropHeight = height;
			} else {
				cropWidth = width;
				cropHeight = width;
			}

			int x = -1;
			int y = -1;

			if (width == height) {
				x = 0;
				y = 0;
			} else if (width > height) {
				x = (width - height) / 2;
				y = 0;
			} else if (width < height) {
				x = 0;
				y = (height - width) / 2;
			}

			ImageStack croppedStack = sp.crop(x, y, cropWidth, cropHeight);

			imp.setStack(null, croppedStack);

			sp = new StackProcessor(imp.getStack(), imp.getProcessor());

			ImageStack resizedStack = sp.resize(150, 150, true);
			imp.setStack(null, resizedStack);
			StringBuffer filePath = new StringBuffer(fileAbsolutePath);
			String saveAsFilePath = filePath.toString();
			IJ.save(imp, saveAsFilePath);
			return saveAsFilePath;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}