package com.inspur.cams.welfare.base.domain.support;

import java.math.BigDecimal;
import java.util.*;
import java.sql.*;

import org.loushang.next.data.*;
//import org.loushang.util.Page;
//import org.loushang.util.RowSelection;
import org.osoa.sca.annotations.*;
import  com.inspur.cams.welfare.base.data.*;
import  com.inspur.cams.welfare.base.dao.*;
import com.inspur.cams.welfare.base.domain.IWealUnitApplyDomain;
/**
 * @title:WealUnitApplyDomain
 * @description:
 * @author:
 * @since:2013-06-08
 * @version:1.0
*/
 public class WealUnitApplyDomain implements IWealUnitApplyDomain {

	private IWealUnitApplyDao wealunitapplyDao;
	

	@Reference
	public void setWealUnitApplyDao(IWealUnitApplyDao wealunitapplyDao) {
		this.wealunitapplyDao = wealunitapplyDao;
	}

	public void saveWealUnitApply(List<WealUnitApply> list) {
		this.wealunitapplyDao.save(list);

	}

	public void delete(List<String> list) {
		String[] wealunitapplyIds = list.toArray(new String[list.size()]);
		if (list != null && !list.isEmpty()) {
			this.wealunitapplyDao.batchDelete(wealunitapplyIds);
		}
	}

	public DataSet queryWealUnitApply(ParameterSet pset) {
		return wealunitapplyDao.query(pset);
	}






}