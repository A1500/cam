package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleEdu;

/**
 * @title:教育Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleEduDomain {
	/**
	 * 查询教育
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加教育
	 * @param samPeopleEdu
	 */
	@Trans
	public void insert(SamPeopleEdu samPeopleEdu);
	
	/**
	 * 更新教育
	 * @param samPeopleEdu
	 */
	@Trans
	public void update(SamPeopleEdu samPeopleEdu);

	/**
	 * 删除教育
	 * @param peopleId
	 */
	@Trans
	public void delete(String peopleId);
}
