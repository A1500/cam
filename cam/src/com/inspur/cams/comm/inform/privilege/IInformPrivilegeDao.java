package com.inspur.cams.comm.inform.privilege;

import java.util.List;
import org.loushang.next.dao.BaseCURD;

/**
 * @title:IInInformPrivilegeDao
 * @description:
 * @author:
 * @since:2009-10-28
 * @version:1.0
*/
 public interface IInformPrivilegeDao extends BaseCURD<InformPrivilege>{
	public void save(List<InformPrivilege> list);
}

