package com.inspur.cams.cdc.base.cmd;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;
import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;
import sun.misc.BASE64Encoder;
import com.inspur.cams.cdc.base.data.CdcPicInfo;
import com.inspur.cams.cdc.base.domain.ICdcPicInfoDomain;
import com.inspur.cams.comm.util.CamsProperties;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区图片展示cmd
 * @author shgtch
 * @date 2011-12-20
 */
public class CdcPicInfoCmd extends BaseAjaxCommand {
	private static final String file_dir = CamsProperties.getString("file_dir");
	private ICdcPicInfoDomain cdcPicInfoDomain = ScaComponentFactory
			.getService(ICdcPicInfoDomain.class, "cdcPicInfoDomain/cdcPicInfoDomain");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		CdcPicInfo cdcPicInfo = (CdcPicInfo) record.toBean(CdcPicInfo.class);

		/*
		 * 将图片上传到服务器
		 */
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadFile = wrapRequest.getUploadFile("idFile"); // 获得上传的模板
		String suffFileName = (String)getParameter("suffFileName"); //模板后缀名
		String filePath = "";
		if (uploadFile != null) { // 如果模板不为空
			if (uploadFile.getFileSize() > 5 * 1024 * 1024) { //设置上传文件最大值
				throw new RuntimeException("附件最大不能超过5M");
			}

			@SuppressWarnings("unused")
			String file_name = uploadFile.getFileName(); // 模板名称
			String pathDir = file_dir + "/" + "jiCengPhoto";// 上传模板目录
			
			File file = new File(pathDir);
			if (!file.exists()) { // 创建上传模板目录
				file.mkdirs();
			}
			
			String file_id = IdHelp.getUUID30(); // 模板文件数据库主键
			filePath = pathDir + "/" + file_id + "." + suffFileName; // 模板路径(防止重复)
			file = new File(filePath);
			byte[] buffer = new byte[1024 * 10];
			FileOutputStream out = null;
			InputStream in = null;
			int size = 0;
			
			try {
				out = new FileOutputStream(file);
				in = uploadFile.getInputStream();
				while ((size = in.read(buffer)) != -1) {
					out.write(buffer,0,size);
					out.flush();
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
				
		}	 
		/*
		 * 将图片转换成二进制并转换成BASE64编码
		 */
		 if (!"".equals(filePath)) {
			filePath.replaceAll("/", "\\\\");
		
		BASE64Encoder encoder = new sun.misc.BASE64Encoder();
        File f = new File(filePath);
        BufferedImage bi;  
        try {  
            bi = ImageIO.read(f);  
            ByteArrayOutputStream baos = new ByteArrayOutputStream();  
            ImageIO.write(bi, "jpg", baos);  
            byte[] bytes = baos.toByteArray();  
            cdcPicInfo.setPhotoTemp(encoder.encodeBuffer(bytes).trim());
            /*
             * 获取到图片的base64编码后
             * 将服务器上传的图片删除
             */
            if (f.exists()) {
				f.delete();
			}
        } catch (IOException e) {  
            e.printStackTrace();  
        }   
		cdcPicInfoDomain.insert(cdcPicInfo);
	}
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcPicInfo cdcPicInfo = (CdcPicInfo) record.toBean(CdcPicInfo.class);
		cdcPicInfoDomain.update(cdcPicInfo);
	}
	
	//删除
	public void delete(){
		String id = (String) getParameter("delId");
		cdcPicInfoDomain.delete(id);
	}
	
}