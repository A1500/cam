package com.inspur.cams.sorg.base.dao.jdbc;

import java.sql.Types;
import java.util.List;
import java.util.Map;

import org.loushang.next.dao.EntityDao;
import org.loushang.next.data.DataSet;

import com.inspur.cams.sorg.base.dao.ISomSessionDao;
import com.inspur.cams.sorg.base.data.SomSession;

/**
 * 社会组织届次dao
 * @author zhangjian
 * @date 2011-9-19
 */
public class SomSessionDao extends EntityDao<SomSession> implements
		ISomSessionDao {
	//负责人备案中用的
	public static String CURRENT_SESSION_SQL = "SELECT * FROM SOM_SESSION S WHERE nvl(SEQ,0)=(SELECT MAX(TO_NUMBER(nvl(SEQ,0)))  FROM SOM_SESSION T WHERE T.SORG_ID=?) AND S.SORG_ID=?";
	//查询换届中的会议信息作为届次
	public static String LAST_SESSION_SQL ="SELECT MEETING_ID FROM SOM_ELECTION WHERE CREATE_TIME=(SELECT MAX(A.CREATE_TIME) FROM SOM_ELECTION A,SOM_APPLY B WHERE  A.TASK_CODE=B.TASK_CODE AND B.IF_FINISH='1' AND A.SORG_ID=?)";

	//查询该登记证号的社会组织下面是否存在填写的届次名称
	public static String FIND_SESSION_EXIST ="select S.* from som_organ t ,som_session s where t.sorg_id=s.sorg_id  AND T.SORG_CODE=? AND S.SESSION_NAME=? AND T.SORG_ID != ?";

	@Override
	protected Class<SomSession> getEntityClass() {
		return SomSession.class;
	}

	/**
	 * 查询当前届次信息
	 * @return
	 */
	public DataSet getCurrentSession(String sorgId) {
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {sorgId,sorgId};

		List list = executeQuery(CURRENT_SESSION_SQL, types, objs);
		DataSet ds = new DataSet();
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			SomSession somSession = new SomSession();
			somSession.setSessionId((String) map.get("SESSION_ID"));
			somSession.setSorgId((String) map.get("SORG_ID"));
			somSession.setTaskCode((String) map.get("TASK_CODE"));
			somSession.setSeq((String) map.get("SEQ"));
			somSession.setSessionName((String) map.get("SESSION_NAME"));
			somSession.setStartDate((String) map.get("START_DATE"));
			somSession.setEndDate((String) map.get("END_DATE"));
			somSession.setRealEndDate((String) map.get("REAL_END_DATE"));
			somSession.setTenure((String) map.get("TENURE"));
			somSession.setDealFlag((String) map.get("DEAL_FLAG"));
			somSession.setMorgName((String) map.get("MORG_NAME"));
			somSession.setMorgArea((String) map.get("MORG_AREA"));
			somSession.setCreatePeople((String) map.get("CREATE_PEOPLE"));
			somSession.setCreateTime((String) map.get("CREATE_TIME"));
			ds.addRecord(somSession);
		}
		return ds;
	}

	/**
	 * 根据换届信息中的会议信息取届次信息，apply表insert方法中调用
	 * @param sorgId
	 * @return meetingId（负责人备案中的sessionId和meetingId一致）
	 */
	public String getLastSessionInfo(String sorgId) {
		int[] types = new int[] {Types.VARCHAR};
		Object[] objs = new Object[] {sorgId};

		List list = executeQuery(LAST_SESSION_SQL, types, objs);
		DataSet ds = new DataSet();
		String meetingId = "";
		for (int i = 0; i < list.size(); i++) {
			Map map = (Map) list.get(i);
			meetingId = (String) map.get("MEETING_ID");
		}
		return meetingId;
	}
	/**
	 * 查询该登记证号的社会组织下面是否存在填写的届次名称
	 * @param sorgCode 登记证号
	 * @param sessionName  届次名称
	* @param sorgId  sorgId
	 */
	public DataSet findIfExist(String sorgCode, String sessionName,String sorgId) {
		int[] types = new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		Object[] objs = new Object[] {sorgCode,sessionName,sorgId};

		return executeDataset(FIND_SESSION_EXIST,types, objs, true);
	}

}
