package com.inspur.cams.drel.sam.domain;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.loushang.sca.transaction.Trans;
import com.inspur.cams.drel.sam.data.SamPeopleExtend;
/**
 * @title:人员扩展信息Domain接口
 * @description:
 * @author: yanliangliang
 * @date:2012年5月16日
 * @version:1.0
 */
public interface ISamPeopleExtendDomain {
	/**
	 * 查询人员扩展信息
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset);

	/**
	 * 增加人员扩展信息
	 * @param samPeopleExtend
	 */
	@Trans
	public void insert(SamPeopleExtend samPeopleExtend);
	
	/**
	 * 更新人员扩展信息
	 * @param samPeopleExtend
	 */
	@Trans
	public void update(SamPeopleExtend samPeopleExtend);
	
	/**
	 * 根据人员id删除人员扩展信息
	 * @param peopleId
	 */
	public void deleteByPeopleId(String peopleId);
}
