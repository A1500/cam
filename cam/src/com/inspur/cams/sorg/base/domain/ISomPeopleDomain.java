package com.inspur.cams.sorg.base.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;

import com.inspur.cams.sorg.base.data.SomPeople;

/**
 * 社会组织人员domain接口
 * @author Muqi
 * @date 2011-5-11
 */
public interface ISomPeopleDomain {
	
	/**
	 * 查询人员信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);
	
	/**
	 * 查询带有受限信息的人员信息
	 * @return
	 */
	public DataSet queryRestrict(ParameterSet pset);
	
	/**
	 * 增加人员信息
	 * @param somPeople
	 */
	@Trans
	public void insert(SomPeople somPeople);
	
	/**
	 * 更新人员信息
	 * @param somPeople
	 */
	@Trans
	public void update(SomPeople somPeople);
	
	/**
	 * 人员建档
	 * 根据身份证号索引，如果无索引结果则新建人员档案，如果查询到则更新原人员档案
	 * @param somPeople
	 * @return 返回人员索引编号
	 */
	@Trans
	public String create(SomPeople somPeople);
	
	/**
	 * 保存照片并返回照片Id
	 * @param photoText
	 * @return
	 */
	@Trans
	public String savePhoto(String photoText);
	
	/**
	 * 更新照片
	 * @param photoId
	 * @param photoText
	 */
	@Trans
	public String updatePhoto(String photoId, String photoText);
	
}
