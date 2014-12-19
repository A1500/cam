package com.inspur.cams.bpt.base.dao.jdbc;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.dao.IBptComfortNoDao;
import com.inspur.cams.bpt.base.data.BptComfortNo;



/**
 * @title:BptPeopleDao
 * @description:优抚人员信息
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class BptComfortNoDao extends EntityDao<BptComfortNo> implements IBptComfortNoDao{

	@Override
	protected Class<BptComfortNo> getEntityClass() {
		return BptComfortNo.class;
	}
}
