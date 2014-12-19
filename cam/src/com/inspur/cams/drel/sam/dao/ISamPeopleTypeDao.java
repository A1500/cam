package com.inspur.cams.drel.sam.dao;

import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.drel.sam.data.SamPeopleType;

/**
 * @title:人员类型dao接口
 * @description:
 * @author:zhangjian
 * @since:2012-05-28
 * @version:1.0
 */
public interface ISamPeopleTypeDao extends BaseCURD<SamPeopleType> {
	/**
	 * 根据人员id删除
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId);
}
