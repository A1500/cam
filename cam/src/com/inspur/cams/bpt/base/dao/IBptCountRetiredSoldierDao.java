package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

import com.inspur.cams.bpt.base.data.BptCountRetiredSoldier;

/**
 * @title:IBptCountRetiredSoldierDao
 * @description:
 * @author:
 * @since:2011-08-04
 * @version:1.0
*/
 public interface IBptCountRetiredSoldierDao extends BaseCURD<BptCountRetiredSoldier>{
	public void save(List<BptCountRetiredSoldier> list);
}

