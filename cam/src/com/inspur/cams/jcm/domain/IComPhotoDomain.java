package com.inspur.cams.jcm.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.jcm.data.ComPhoto;

/**
 * 人员照片表domain
 * @author 陈寿业
 * @date 2014-05-16
 */
public interface IComPhotoDomain {

	/**
	 * 查询 人员照片表
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 获取 人员照片表
	 * @param pset
	 * @return
	 */
	public ComPhoto get(String photoId);

	/**
	 * 增加 人员照片表
	 * @param comPhoto
	 */
	@Trans
	public void insert(ComPhoto comPhoto);
	
	/**
	 * 修改 人员照片表
	 * @param comPhoto
	 */
	@Trans
	public void update(ComPhoto comPhoto);
	
	/**
	 * 删除 人员照片表
	 * @param photoId
	 */
	@Trans
	public void delete(String photoId);

}