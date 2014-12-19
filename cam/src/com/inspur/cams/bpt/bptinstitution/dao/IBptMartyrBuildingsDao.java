package com.inspur.cams.bpt.bptinstitution.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.bptinstitution.data.BptMartyrBuildings;


/**
 * @title:IBptMartyrBuildingsDao
 * @description:
 * @author:
 * @since:2011-06-15
 * @version:1.0
*/
 public interface IBptMartyrBuildingsDao extends BaseCURD<BptMartyrBuildings>{
	public void save(List<BptMartyrBuildings> list);
}

