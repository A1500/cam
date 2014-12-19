package com.inspur.cams.comm.extuser.dao.jdbc;

import java.sql.Types;
import java.util.List;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;
import org.loushang.next.data.ParameterSet;

import com.inspur.cams.comm.extuser.dao.IComExtUserDao;
import com.inspur.cams.comm.extuser.data.ComExtUser;

/**
 * 外部单位用户dao实现类
 * @author shgtch
 * @date 2011-6-29
 */
public class ComExtUserDao extends EntityDao<ComExtUser> implements IComExtUserDao {

	// 根据用户内码逻辑删除用户信息
	public static String DELETE_BY_USER_ID = "UPDATE COM_EXT_USER SET IN_USE='0' WHERE USER_ID=?";
	// 根据单位内码逻辑删除用户信息
	public static String DELETE_BY_ORGAN_ID = "UPDATE COM_EXT_USER SET IN_USE='0' WHERE ORGAN_ID=?";
	// 龙头企业根据用户名字修改密码
	public static String UPDATE_PASSWORD_BY_ID = "UPDATE COM_EXT_USER SET PWD=?  WHERE USER_ID=?";

	// 根据用户内码逻辑删除用户信息
	public static String DELETE_BY_USER_ID_REAL = "DELETE FROM COM_EXT_USER  WHERE USER_ID=?";

	@Override
	protected Class getEntityClass() {
		return ComExtUser.class;
	}

	/**
	 * 获取外部单位用户信息
	 * @param userId
	 * @return
	 */
	public ComExtUser getComExtUser(String userId) {
		return get(userId);
	}

	/**
	 * 增加外部单位用户信息
	 * @param comExtUser
	 */
	public void insertComExtUser(ComExtUser comExtUser) {
		insert(comExtUser);
	}

	/**
	 * 更新外部单位用户信息
	 * @param comExtUser
	 */
	public void updateComExtUser(ComExtUser comExtUser) {
		update(comExtUser);
	}

	/**
	 * 逻辑删除外部单位用户信息
	 * @param userId
	 */
	public void deleteComExtUser(String userId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {userId};
		executeUpdate(DELETE_BY_USER_ID, types, objs);
	}
	
	
	public void saveUser(List list)
	  {
	    save(list);
	  }

  public void deleteSelected(String[] delIds)
  {
    batchDelete(delIds);
  }

	/**
	 * 根据单位内码逻辑删除用户
	 * @param organId
	 */
	public void deleteComExtUserByOrganId(String organId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {organId};
		executeUpdate(DELETE_BY_ORGAN_ID, types, objs);
	}

	/**
	 * 查询外部单位用户信息
	 * @param ps
	 * @return
	 */
	public DataSet queryExtUser(ParameterSet ps) {
		return query(ps);
	}

	public void delete(String userId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {userId};
		executeUpdate(DELETE_BY_USER_ID_REAL, types, objs);
	}

	/**
	 * 根据龙头企业的用户名修改密码
	 * @param userId
	 */
	public void updatePassWord(String userId,String passWord) {
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {passWord,userId};

		executeUpdate(UPDATE_PASSWORD_BY_ID, types, objs);
	}


	public void batchUpdateComExtUser(List<ComExtUser> comExtUsers) {
		// TODO Auto-generated method stub

	}
	/***
	 * 更改外部组织名称通过变更社会组织名称
	 */


	public void updateExtuserbychangge(String changgebefore,String changgeafter) {
		// TODO Auto-generated method stub
		 String sql1="update  com_ext_user set   com_ext_user.user_id=? , com_ext_user.user_name=?  where com_ext_user.user_id='"+changgebefore+"'";
		 int[] types = new int[] {Types.VARCHAR,Types.VARCHAR};
		 Object[] objs = new Object[] {changgeafter,changgeafter};

		 executeUpdate(sql1, types, objs);
	}


	public void updatesomExtuserMenubychangge(String changgebefore,	String changgeafter) {
		// TODO Auto-generated method stub
		 String sql1="update  som_Extuser_Menu set  user_id=?  where user_id='"+changgebefore+"'";
		 int[] types = new int[] {Types.VARCHAR};
		 Object[] objs = new Object[] {changgeafter};

		 executeUpdate(sql1, types, objs);

	}

	public void updateSorgcode(String sorgcode,String cnName ) {
		// TODO Auto-generated method stub
		 String sql1="update  som_extuser_menu set   som_extuser_menu.sorg_code=? where id=?";
		 int[] types = new int[] {Types.VARCHAR,Types.VARCHAR };

		 Object[] objs = new Object[] {sorgcode,cnName};

		 executeUpdate(sql1, types, objs);
	}
/**
 * 2014年3月20日
 */
	public Integer ifcreateextuser(String user_name) {
		// TODO Auto-generated method stub
		int count=0;
		String sql="select  com_ext_user.user_id  from  com_ext_user  where  com_ext_user.user_id= '"+user_name+"'";
	List list=	executeQuery(sql);
	 if(list!=null) count=list.size();
		return count;
	}

}
