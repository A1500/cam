package com.inspur.cams.marry.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.marry.base.data.MrmPhotoInfo;

	/**
	 * 机关照片
	 * @author shgtch
	 * @date 2011-12-5
	 */
public interface IMrmPhotoInfoDomain {
	
	/**
	 * 查询机关图片展示
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加机关图片展示
	 * @param cdcPicInfo
	 */
	@Trans
	public void insert(MrmPhotoInfo mrmPhotoInfo);
	
	/**
	 * 修改机关图片展示
	 * @param cdcPicInfo
	 */
	@Trans
	public void update(MrmPhotoInfo mrmPhotoInfo);
	
	/**
	 * 删除机关图片展示
	 * @param id
	 */
	@Trans
	public void delete(String id);
	
	/**
	 * 查询机关图片
	 */
	public DataSet queryPhotoInfo(ParameterSet pset);
}
