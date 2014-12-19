package com.inspur.cams.sorg.base.domain.support;


import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.comm.util.BspUtil;
import com.inspur.cams.comm.util.DateUtil;
import com.inspur.cams.comm.util.IdHelp;
import com.inspur.cams.comm.util.PhotoUtil;
import com.inspur.cams.sorg.base.dao.ISomPeopleDao;
import com.inspur.cams.sorg.base.data.SomPeople;
import com.inspur.cams.sorg.base.domain.ISomPeopleDomain;

/**
 * 社会组织人员domain实现类
 * @author Muqi
 * @date 2011年5月12日17:52:01
 */
public class SomPeopleDomain implements ISomPeopleDomain {

	@Reference
	private ISomPeopleDao somPeopleDao;

	/**
	 * 查询人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return somPeopleDao.query(pset);
	}

	/**
	 * 查询带有受限信息的人员信息
	 * @return
	 */
	public DataSet queryRestrict(ParameterSet pset){
		return somPeopleDao.queryRestrict(pset);
	}
	
	/**
	 * 增加人员信息
	 * @param dataBean
	 */
	public void insert(SomPeople dataBean) {
		somPeopleDao.insert(dataBean);
	}

	/**
	 * 更新人员信息
	 * @param dataBean
	 */
	public void update(SomPeople dataBean) {
		somPeopleDao.update(dataBean);
	}

	/**
	 * 人员建档
	 * 根据身份证号索引，如果无索引结果则新建人员档案，如果查询到则更新原人员档案
	 * @param somPeople
	 * @return 返回人员索引编号
	 */
	public String create(SomPeople somPeople) {
		//保存照片
		String base64Code = somPeople.getPhotoText();
		String photoId = "";
		if (null != base64Code && !"".equals(base64Code)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			photoId = PhotoUtil.savePhoto(base64Code);
		}
		if (photoId != null && !"".equals(photoId)) {
			somPeople.setPhotoId(photoId);
		}
		if (somPeople.getPeopleId() == null || "".equals(somPeople.getPeopleId())||somPeople.getPeopleId().length()!=32) {
			somPeople.setPeopleId(IdHelp.getUUID32());
			//somPeople.setCreatePeople(BspUtil.getEmpOrgan().getOrganName());
			somPeople.setCreateTime(DateUtil.getTime());
			somPeopleDao.insert(somPeople);
		} else {
			somPeopleDao.update(somPeople);
		}
		return somPeople.getPeopleId();
	}
	
	/**
	 * 保存照片并返回照片Id
	 */
	public String savePhoto(String photoText) {
		String photoId = "";
		if (null != photoText && !"".equals(photoText)) {
			// 保存图片到表 COM_PHOTO 中，并返回该图片的主键
			photoId = PhotoUtil.savePhoto(photoText);
		}
		return photoId;
	}
	
	/**
	 * 更新照片
	 */
	public String updatePhoto(String photoId, String photoText) {
		return somPeopleDao.updatePhoto(photoId, photoText);
	}

}
