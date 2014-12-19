package com.inspur.cams.sorg.base.domain.support;

import java.util.List;

import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;
import org.osoa.sca.annotations.Reference;

import com.inspur.cams.sorg.base.dao.IDicSomDutyDao;
import com.inspur.cams.sorg.base.data.DicSomDuty;
import com.inspur.cams.sorg.base.domain.IDicSomDutyDomain;

/**
 * 社会组织职务domian实现类
 * @author Jiangzhaobao
 * @date 2011-6-18
 */
public class DicSomDutyDomain implements IDicSomDutyDomain {
	
	@Reference
	private IDicSomDutyDao dicSomDutyDao;

	/**
	 * 查询社会组织职务
	 * @param pset
	 * @return
	 */
	public DataSet query(ParameterSet pset) {
		return dicSomDutyDao.query(pset);
	}

	/**
	 * 保存社会组织职务
	 * @param list
	 */
	public void save(List<DicSomDuty> list) {
		dicSomDutyDao.save(list);
	}

	
}
