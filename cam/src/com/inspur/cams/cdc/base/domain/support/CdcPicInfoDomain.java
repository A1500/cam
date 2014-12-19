package com.inspur.cams.cdc.base.domain.support;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.math.BigDecimal;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.ScaComponentFactory;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.cdc.base.dao.ICdcPicInfoDao;
import com.inspur.cams.cdc.base.data.CdcPicInfo;
import com.inspur.cams.cdc.base.domain.ICdcPicInfoDomain;
import com.inspur.cams.comm.comphoto.data.ComPhoto;
import com.inspur.cams.comm.comphoto.domain.ComPhotoDomain;
import com.inspur.cams.comm.comphoto.domain.IComPhotoDomain;
import com.inspur.cams.comm.lob.Blob;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;

/**
 * 社区图片展示domain实现类
 * @author shgtch
 * @date 2012-2-7
 */
public class CdcPicInfoDomain implements ICdcPicInfoDomain {

	@Reference
	private ICdcPicInfoDao cdcPicInfoDao;
	private IComPhotoDomain comPhotoDomain = ScaComponentFactory.getService(ComPhotoDomain.class, "ComPhotoDomain/ComPhotoService");
	
	
	/**
	 * 查询社区图片展示
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return cdcPicInfoDao.query(pset);
	}

	/**
	 * 增加社区图片展示
	 * @param cdcPicInfo
	 */
	public void insert(CdcPicInfo cdcPicInfo) {
		cdcPicInfo.setId(cdcPicInfo.getOrganCode() + IdHelp.getUUID32());
	//	System.out.println(makePhotoId(cdcPicInfo));
		cdcPicInfo.setContent(savePhotoCode(cdcPicInfo));
		cdcPicInfoDao.insert(cdcPicInfo);
	}
	
	/**
	 * 修改社区图片展示
	 * @param cdcConstructInfo
	 */
	public void update(CdcPicInfo cdcPicInfo) {
		cdcPicInfoDao.update(cdcPicInfo);
	}
	
	/**
	 * 删除社区图片展示
	 * @param id
	 */
	public void delete(String id) {
		cdcPicInfoDao.delete(id);
	}
	
	/**
	 * 保存图片
	 */

	public String savePhotoCode(CdcPicInfo cdcPicInfo){
		String base64Code = cdcPicInfo.getPhotoTemp();
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

	public DataSet queryPicInfo(ParameterSet pset) {
		// TODO Auto-generated method stub
		return cdcPicInfoDao.queryPicInfo(pset);
	}
}