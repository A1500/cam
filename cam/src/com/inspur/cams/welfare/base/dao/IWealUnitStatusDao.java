package com.inspur.cams.welfare.base.dao;

import java.util.List;
import org.loushang.next.dao.BaseCURD;
import com.inspur.cams.welfare.base.data.*;

/**
 * @title:IWealUnitStatusDao
 * @description:
 * @author:liuxin
 * @since:2013-06-08
 * @version:1.0
 */
public interface IWealUnitStatusDao extends BaseCURD<WealUnitStatus> {
	public void save(List<WealUnitStatus> list);
}
