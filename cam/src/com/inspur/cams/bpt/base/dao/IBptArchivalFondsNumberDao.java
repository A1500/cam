package com.inspur.cams.bpt.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.bpt.base.data.BptArchivalFondsNumber;

/**
 * @title:IBptArchivalFondsNumberDao
 * @description:全宗号维护
 * @author:
 * @since:2011-07-22
 * @version:1.0
*/
 public interface IBptArchivalFondsNumberDao extends BaseCURD<BptArchivalFondsNumber>{
	public void save(List<BptArchivalFondsNumber> list);
}

