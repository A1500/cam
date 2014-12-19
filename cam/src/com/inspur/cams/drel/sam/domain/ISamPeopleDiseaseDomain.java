package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleDisease;
/**
 * @title:患病Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleDiseaseDomain {
	/**
	 * 查询患病
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加患病
	 * @param samPeopleDisease
	 */
	@Trans
	public void insert(SamPeopleDisease samPeopleDisease);
	
	/**
	 * 更新患病
	 * @param samPeopleDisease
	 */
	@Trans
	public void update(SamPeopleDisease samPeopleDisease);
	
	/**
	 * 删除患病
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);
}
