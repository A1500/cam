package com.inspur.cams.marry.base.cmd;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.loushang.next.data.*;
import org.loushang.next.web.cmd.*;
import org.loushang.sca.ScaComponentFactory;

import sun.misc.BASE64Encoder;

import com.inspur.cams.marry.base.data.MrmPhotoInfo;
import com.inspur.cams.marry.base.domain.IMrmPhotoInfoDomain;
/**
 * @title:MrmPhotoInfoCommand
 * @description:
 * @author:
 * @since:2012-03-14
 * @version:1.0
*/
public class MrmPhotoInfoCommand extends BaseAjaxCommand{

	private IMrmPhotoInfoDomain mrmPhotoInfoDomain = ScaComponentFactory.
	getService(IMrmPhotoInfoDomain.class, "MrmPhotoInfoDomain/MrmPhotoInfoDomain");

	public void insert() {
		Record record = (Record) getParameter("record");
		MrmPhotoInfo dataBean=(MrmPhotoInfo)record.toBean(MrmPhotoInfo.class);
/*		String fileName = "";
		if (record.get("photoTemp") != null && !"".equals(record.get("photoTemp"))) {
			fileName = record.get("photoTemp").toString();
		}
		 if (!"".equals(fileName)) {
			fileName.replaceAll("/", "\\\\");
		}
		 //将图片转换成二进制并转换成BASE64编码
		BASE64Encoder encoder = new sun.misc.BASE64Encoder();
        File f = new File(fileName);         
        BufferedImage bi;  
        try {  
            bi = ImageIO.read(f);  
            ByteArrayOutputStream baos = new ByteArrayOutputStream();  
            ImageIO.write(bi, "jpg", baos);  
            byte[] bytes = baos.toByteArray();  
            dataBean.setPhotoTemp(encoder.encodeBuffer(bytes).trim());
        } catch (IOException e) {  
            e.printStackTrace();  
        }   */
		mrmPhotoInfoDomain.insert(dataBean);
	}

	public void update() {
		Record record = (Record) getParameter("record");
		MrmPhotoInfo dataBean=(MrmPhotoInfo)record.toBean(MrmPhotoInfo.class);
		mrmPhotoInfoDomain.update(dataBean);
	}

	public void delete() {
		String delIds=(String) getParameter("delIds");
		mrmPhotoInfoDomain.delete(delIds);
	}
}
