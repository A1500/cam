package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleDisability;

/**
 * @title:残疾Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleDisabilityDomain {
	/**
	 * 查询残疾
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加残疾
	 * @param samPeopleDisability
	 */
	@Trans
	public void insert(SamPeopleDisability samPeopleDisability);
	
	/**
	 * 更新残疾
	 * @param samPeopleDisability
	 */
	@Trans
	public void update(SamPeopleDisability samPeopleDisability);

	/**
	 * 删除残疾
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);
}
