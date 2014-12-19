package com.inspur.cams.comm.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;

import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.comphoto.data.ComPhoto;
import com.inspur.cams.comm.comphoto.domain.ComPhotoDomain;
import com.inspur.cams.comm.comphoto.domain.IComPhotoDomain;
import com.inspur.cams.comm.lob.Blob;

public class PhotoUtil {
	@Reference
	private static IComPhotoDomain comPhotoDomain = ScaComponentFactory.getService(ComPhotoDomain.class, "ComPhotoDomain/ComPhotoService");
	/**
	 * 保存相片
	 * @param photoContent
	 * @return 相片ID
	 */
	public static String savePhoto(String photoContent){
		ComPhoto comPhoto = new ComPhoto();
		Blob blob = new Blob();
		blob.setData(photoContent);
		comPhoto.setPhotoContent(blob);
		
		try {
			comPhoto.setPhotoSize(new BigDecimal(blob.getFileData().length));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		comPhoto.setPhotoId(IdHelp.getUUID30());
		comPhoto.setCreateDate(DateUtil.getTime());
		comPhoto.setCreateOpr(BspUtil.getEmpOrganId());
		comPhoto.setCreateOrgan(BspUtil.getCorpOrganId());
		comPhoto.setPhotoType("JPG");
		comPhotoDomain.insertPhoto(comPhoto);
		return comPhoto.getPhotoId();
	}
	public static String savePhoto(String photoContent,String cardPhotoContent){
		ComPhoto comPhoto = new ComPhoto();
		Blob blob = new Blob();
		blob.setData(photoContent);
		comPhoto.setPhotoContent(blob);
		Blob cardblob = new Blob();
		cardblob.setData(cardPhotoContent);
		comPhoto.setCardPhotoContent(cardblob);
		try {
			comPhoto.setPhotoSize(new BigDecimal(blob.getFileData().length));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		comPhoto.setPhotoId(IdHelp.getUUID30());
		comPhoto.setCreateDate(DateUtil.getTime());
		comPhoto.setCreateOpr(BspUtil.getEmpOrganId());
		comPhoto.setCreateOrgan(BspUtil.getCorpOrganId());
		comPhoto.setPhotoType("JPG");
		comPhotoDomain.insertPhoto(comPhoto);
		return comPhoto.getPhotoId();
	}

}
