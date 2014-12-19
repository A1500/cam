package com.inspur.cams.welfare.base.dao.support;


import org.loushang.next.dao.EntityDao;

import com.inspur.cams.bpt.base.data.BptComfortNo;
import com.inspur.cams.welfare.base.dao.IWealComfortNoDao;
import com.inspur.cams.welfare.base.data.WealComfortNo;



/**
 * WealComfortNoDao
 * @description:
 * @author:
 * @since:2011-05-21
 * @version:1.0
*/
 public class WealComfortNoDao extends EntityDao<WealComfortNo> implements IWealComfortNoDao{

	@Override
	protected Class<WealComfortNo> getEntityClass() {
		return WealComfortNo.class;
	}
}
