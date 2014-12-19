package com.inspur.cams.sorg.base.dao;

import org.loushang.next.dao.BaseCURD;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.sorg.base.data.SomPeople;

/**
 * 社会组织人员dao接口
 * @author Muqi
 * @date 2011-5-11
 */
public interface ISomPeopleDao extends BaseCURD<SomPeople> {
	/**
	 * 更新照片
	 * @param photoId
	 * @param photoText
	 */
	public String updatePhoto(String photoId,String photoText);
	/**
	 * 查询带有受限信息的人员信息
	 * @return
	 */
	public DataSet queryRestrict(ParameterSet pset);
}
