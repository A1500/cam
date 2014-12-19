package com.inspur.cams.sorg.jxcheck.somjxcheckfacing.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:ISomJxCheckFacingDao
 * @description:
 * @author:
 * @since:2012-01-14
 * @version:1.0
*/
 public interface ISomJxCheckFacingDao extends BaseCURD<SomJxCheckFacing>{
	public void save(List<SomJxCheckFacing> list);
}

