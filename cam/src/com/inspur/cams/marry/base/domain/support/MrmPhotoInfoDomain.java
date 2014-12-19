package com.inspur.cams.marry.base.domain.support;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.comphoto.data.ComPhoto;
import com.inspur.cams.comm.comphoto.domain.ComPhotoDomain;
import com.inspur.cams.comm.comphoto.domain.IComPhotoDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.marry.base.dao.IMrmPhotoInfoDao;
import com.inspur.cams.marry.base.data.MrmPhotoInfo;
import com.inspur.cams.marry.base.domain.IMrmPhotoInfoDomain;

public class MrmPhotoInfoDomain implements IMrmPhotoInfoDomain {
	@Reference
	private IMrmPhotoInfoDao mrmPhotoInfoDao;
	private IComPhotoDomain comPhotoDomain = ScaComponentFactory.getService(ComPhotoDomain.class, "ComPhotoDomain/ComPhotoService");
	
	public void delete(String id) {
		mrmPhotoInfoDao.delete(id);
	}
	/**
	 * 增加机关图片
	 */
	public void insert(MrmPhotoInfo mrmPhotoInfo) {
		mrmPhotoInfo.setId(mrmPhotoInfo.getOrganCode() + IdHelp.getUUID32());
		mrmPhotoInfo.setContent(savePhotoCode(mrmPhotoInfo));
		mrmPhotoInfoDao.insert(mrmPhotoInfo);
	}

	public DataSet query(ParameterSet pset) {
		return mrmPhotoInfoDao.query(pset);
	}

	public void update(MrmPhotoInfo mrmPhotoInfo) {
		mrmPhotoInfoDao.update(mrmPhotoInfo);
	}
	
	/**
	 * 保存图片
	 */

	public String savePhotoCode(MrmPhotoInfo mrmPhotoInfo){
		String base64Code = mrmPhotoInfo.getPhotoTemp();
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
			comPhoto.setPhotoId(IdHelp.getUUID30());
			comPhoto.setCreateDate(DateUtil.getTime());
			comPhoto.setPhotoType("JPG");
			comPhotoDomain.insertPhoto(comPhoto);
			return comPhoto.getPhotoId();
		}
		return null;
	}
	/**
	 * 查询机关图片
	 */
	public DataSet queryPhotoInfo(ParameterSet pset) {
		return mrmPhotoInfoDao.queryPhotoInfo(pset);
	}
}
