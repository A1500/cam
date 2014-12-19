package com.inspur.cams.cdc.base.cmd;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;

import javax.imageio.ImageIO;

import org.loushang.next.data.Record;
import org.loushang.next.upload.MultipartRequestWrapper;
import org.loushang.next.upload.UploadFile;
import org.loushang.next.web.cmd.BaseAjaxCommand;
import org.loushang.sca.ScaComponentFactory;

import sun.misc.BASE64Encoder;

import com.inspur.cams.cdc.base.data.CdcVoluntaryInfo;
import com.inspur.cams.cdc.base.domain.ICdcVoluntaryInfoDomain;
import com.inspur.cams.comm.comphoto.data.ComPhoto;
import com.inspur.cams.comm.comphoto.domain.ComPhotoDomain;
import com.inspur.cams.comm.comphoto.domain.IComPhotoDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 志愿者信息cmd
 * @author 
 * @date 2013-02-26
 */
public class CdcVoluntaryInfoCmd extends BaseAjaxCommand {

	private ICdcVoluntaryInfoDomain cdcVoluntaryInfoDomain = ScaComponentFactory
			.getService(ICdcVoluntaryInfoDomain.class, "cdcVoluntaryInfoDomain/cdcVoluntaryInfoDomain");
	
	private IComPhotoDomain comPhotoDomain = ScaComponentFactory.getService(ComPhotoDomain.class, "ComPhotoDomain/ComPhotoService");
	
	// 增加
	public void insert() {
		Record record = (Record) getParameter("record");
		String method = (String)getParameter("method");
		CdcVoluntaryInfo cdcVoluntaryInfo = (CdcVoluntaryInfo) record.toBean(CdcVoluntaryInfo.class);
		
		//将图片上传到服务器
		MultipartRequestWrapper wrapRequest = (MultipartRequestWrapper) getRequest();// 获取包装后的request
		UploadFile uploadFile = wrapRequest.getUploadFile("idFile"); // 获得上传的模板
		if (uploadFile != null) { // 如果模板不为空
			if (uploadFile.getFileSize() > 3 * 1024 * 1024) { // 设置上传文件最大值
				throw new RuntimeException("附件最大不能超过3M");
			}
			//将图片转换成二进制并转换成BASE64编码
			BASE64Encoder encoder = new sun.misc.BASE64Encoder();
	        BufferedImage bi;  
	        try {  
	            bi = ImageIO.read(uploadFile.getInputStream());  
	            ByteArrayOutputStream baos = new ByteArrayOutputStream();  
	            ImageIO.write(bi, "jpg", baos);  
	            byte[] bytes = baos.toByteArray();  
	            
	            String base64Code = encoder.encodeBuffer(bytes).trim();
	            if (null != base64Code && !"".equals(base64Code)) {
	    			ComPhoto comPhoto = new ComPhoto();
	    			Blob blob = new Blob();
	    			blob.setData(base64Code);
	    			comPhoto.setPhotoContent(blob);
	    			try {
	    				comPhoto.setPhotoSize(new BigDecimal(blob.getFileData().length));
	    			} catch (FileNotFoundException e) {
	    				e.printStackTrace();
	    			} catch (IOException e) {
	    				e.printStackTrace();
	    			}
	    			comPhoto.setPhotoId(IdHelp.getUUID32());
	    			comPhoto.setCreateDate(DateUtil.getTime());
	    			comPhoto.setPhotoType("JPG");
	    			comPhotoDomain.insertPhoto(comPhoto);
	    			cdcVoluntaryInfo.setPhotoId(comPhoto.getPhotoId());
	    		}
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }   
		 }
		if("INSERT".equalsIgnoreCase(method)) {
			cdcVoluntaryInfo.setVoluntaryId(IdHelp.getUUID32());
			cdcVoluntaryInfo.setCaperNums(new BigDecimal(0));
			cdcVoluntaryInfo.setCaperTimes(new BigDecimal(0));
			cdcVoluntaryInfo.setCreateTime(DateUtil.getTime());
			cdcVoluntaryInfoDomain.insert(cdcVoluntaryInfo);
		}else {
			cdcVoluntaryInfoDomain.update(cdcVoluntaryInfo);
		}
	}

	// 修改
	public void update() {
		Record record = (Record) getParameter("record");
		CdcVoluntaryInfo cdcVoluntaryInfo = (CdcVoluntaryInfo) record.toBean(CdcVoluntaryInfo.class);
		cdcVoluntaryInfoDomain.update(cdcVoluntaryInfo);
	}
	
	// 删除
	public void delete() {
		String voluntaryId = (String) getParameter("voluntaryId");
		cdcVoluntaryInfoDomain.delete(voluntaryId);
	}
	
}